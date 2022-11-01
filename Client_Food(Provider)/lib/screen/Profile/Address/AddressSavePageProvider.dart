import 'package:flutter/material.dart';
import 'package:/model/FromJSON/AddressBookListModel.dart';
import 'package:/model/FromJSON/CheckDistanceModel.dart';
import 'package:/model/FromJSON/GetLocationModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/ModelView/AddressMaingPage.dart';
import 'package:/model/ModelView/GroupModel.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressSavePageProvider extends ChangeNotifier {
  AddressSavePageProvider();

  AddressBookListModel? model;
  List<AddressBook>? listAddress;
  List<GroupModel> groupData = [
    GroupModel(text: 'บ้าน', selected: false),
    GroupModel(text: 'ออฟฟิศ', selected: false),
    GroupModel(text: 'อื่นๆ', selected: false),
  ];
  List<TextEditingController> textController =
      List.generate(3, (i) => TextEditingController());
  List<String> textFieldError = ['', '', ''];
  int groupValue = 0;
  int indexAddressEdit = 0;
  bool stsHome = true;
  bool stsOffice = true;
  bool stsEtc = true;
  String latText = "";
  String lngText = "";
  String flagAction = '';
  String idAdressEdit = '';
  String checkidLogin = '';
  List<String> addressPageMain = ['', ''];

  bool checkChangeAdress = false;
  String addressCheck = '';
  CheckDistanceModel? searchModel;
  SuccessModel? modelSuccessSearch;

  DetailsResult? detailsResult;

  AddressMaingPage showAddress = new AddressMaingPage(
      address: '',
      addressId: '',
      id: '',
      title: '',
      latitude: '',
      longitude: '');
  Position? userLocation;
  GetLocationModel? locaModel;
  int checkInit = 0;

  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];

  Color colorTextAddressFocus = Colors.black;

  Future getAddress(BuildContext context) async {
    Constants().printColorCyan('|?| getAddress |?|');
    showAddress.title = '';
    showAddress.address = '';

    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    String _address = '';
    _address = preferences.getString('addresstitle').toString();
    var body = {
      "customer_id": customerId,
      "action": "MyAccount",
      "page": "AddressBookList",
      "view": ""
    };
    print('show body gu t address $body');
    try {
      await RestAPI()
          .getData(
            url: ApiPath.addressBookList,
            body: body,
          )
          .then((value) async => {
                if (value['result']['success'].toString() == '1')
                  {
                    model = AddressBookListModel.fromJson(value),
                    listAddress = model!.result!.addressBook!,
                    if ((checkidLogin != customerId.toString()) &&
                        (_address == '' || _address == 'null'))
                      {
                        await selectAddress(0), // select first row address
                        print('show addresss1'),
                        checkidLogin = customerId.toString(),
                        getMainAddress(),
                      }
                    else
                      {
                        print('show addresss2'),
                        showAddress.address =
                            preferences.getString('address').toString(),
                        showAddress.id =
                            preferences.getString('addressid').toString(),
                        showAddress.title =
                            preferences.getString('addresstitle').toString(),
                        listAddress!.forEach((element) {
                          if (element.id.toString() == showAddress.id) {
                            showAddress.addressId = element.flatNo!;
                            showAddress.latitude = element.latitude!;
                            showAddress.longitude = element.longitude!;
                          }
                        }),
                        print('showAddress.latitude ${showAddress.latitude}'),
                        print('showAddress.longitude ${showAddress.longitude}'),
                        notifyListeners(),
                        await getMainAddress(),
                      }
                  }
                else
                  {
                    listAddress = [],
                    getCurrentLocation(context: context),
                  },
                // notifyListeners(),

                //set def show บ้านเลขที่
                if (flagAction == 'add')
                  {
                    checkinitDataAddress(),
                  },
              });
    } on Exception catch (exception, stackTrace_ex) {
      Constants().printColorRed('ErrorOnExceptionFromGetAddress:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error, stackTrace) {
      Constants().printColorRed('ErrorFromGetAddress:: $error');
      Constants().printColorRed('check stack error :  $stackTrace');
    }

    // return [showAddress.latitude, showAddress.longitude];
  }

  Future adddAddress() async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    var body = {
      "customer_id": customerId,
      "action": "MyAccount",
      "page": "AddressBookAdd",
      "title": textController[0].text,
      "flat_no": textController[1].text,
      "address": textController[2].text,
      "latitude": latText,
      "longitude": lngText
    };

    await RestAPI().getData(url: ApiPath.addressBookAdd, body: body);

    if (groupValue == 0) {
      stsHome = false;
    } else if (groupValue == 1) {
      stsOffice = false;
    }

    textController[0].text = '';
    textController[1].text = '';
    textController[2].text = '';
    notifyListeners();
  }

  Future editAddress() async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    var body = {
      "customer_id": customerId,
      "action": "MyAccount",
      "page": "AddressBook",
      "addressBookId": idAdressEdit,
      "addressAction": "AddressBookEdit",
      "title": textController[0].text,
      "flat_no": textController[1].text,
      "address": textController[2].text,
      "latitude": latText,
      "longitude": lngText
    };

    await RestAPI().getData(url: ApiPath.addressBookEdit, body: body);
  }

  Future deleteAddress(String id) async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    var body = {
      "customer_id": customerId,
      "action": "MyAccount",
      "page": "AddressBook",
      "addressBookId": id,
      "addressAction": "AddressBookDelete"
    };

    await RestAPI().getData(url: ApiPath.addressBookDelete, body: body);
  }

  Future selectAddress(int index) async {
    var preferences = await SharedPreferences.getInstance();
    showAddress.title = model!.result!.addressBook![index].title!;
    showAddress.address = model!.result!.addressBook![index].address!;
    showAddress.addressId = model!.result!.addressBook![index].flatNo!;
    showAddress.id = model!.result!.addressBook![index].id.toString();
    showAddress.latitude = listAddress![index].latitude!;
    showAddress.longitude = listAddress![index].longitude!;

    getMainAddress();

    await preferences.setString('address', showAddress.address);
    await preferences.setString('addresstitle', showAddress.title);
    await preferences.setString('addressid', showAddress.id);
    notifyListeners();
  }

  getMainAddress() {
    if (showAddress.address.contains('Khwaeng')) {
      addressPageMain = showAddress.address.split('Khwaeng');
      addressPageMain[1] = 'Khwaeng ${addressPageMain[1]}';
    } else if (showAddress.address.contains('Tambon')) {
      addressPageMain = showAddress.address.split('Tambon');
      addressPageMain[1] = 'Tambon ${addressPageMain[1]}';
    } else if (showAddress.address.contains('Khet')) {
      addressPageMain = showAddress.address.split('Khet');
      addressPageMain[1] = 'Khet ${addressPageMain[1]}';
    } else if (showAddress.address.contains('Amphoe')) {
      addressPageMain = showAddress.address.split('Amphoe');
      addressPageMain[1] = 'Amphoe ${addressPageMain[1]}';
    } else if (showAddress.address.contains('District,')) {
      addressPageMain = showAddress.address.split('District,');
      addressPageMain[0] = '${addressPageMain[0]} District,';
    } else if (showAddress.address.contains('Road,')) {
      addressPageMain = showAddress.address.split('Road,');
      addressPageMain[0] = '${addressPageMain[0]} Road,';
    } else if (showAddress.address.contains('แขวง')) {
      addressPageMain = showAddress.address.split('แขวง');
      addressPageMain[1] = 'แขวง ${addressPageMain[1]}';
    } else if (showAddress.address.contains('ตำบล,')) {
      addressPageMain = showAddress.address.split('ตำบล');
      addressPageMain[1] = 'ตำบล ${addressPageMain[1]}';
    } else if (showAddress.address.contains('เขต,')) {
      addressPageMain = showAddress.address.split('เขต');
      addressPageMain[1] = 'แขวง ${addressPageMain[1]}';
    } else if (showAddress.address.contains('อำเภอ,')) {
      addressPageMain = showAddress.address.split('อำเภอ');
      addressPageMain[1] = 'แขวง ${addressPageMain[1]}';
    } else if (showAddress.address.contains('ถนน,')) {
      addressPageMain = showAddress.address.split('ถนน');
      addressPageMain[1] = 'ถนน ${addressPageMain[1]}';
    } else {
      addressPageMain[0] = showAddress.address;
      addressPageMain[1] = ' - ';
    }

    notifyListeners();
  }

  Future getDataSearch(
      String latCust, String longCust, String latRest, String longRest) async {
    var body = {
      "latitudeCust": latCust,
      "longitudeCust": longCust,
      "latitudeRest": latRest,
      "longitudeRest": longRest
    };
    checkChangeAdress = false;
    try {
      await RestAPI()
          .getData(url: ApiPath.checkDistance, body: body)
          .then((value) {
        {
          searchModel = CheckDistanceModel.fromJson(value);
          checkChangeAdress = searchModel!.result!.success!;
        }
      });
    } catch (e) {
      debugPrint('errro change address $e');
    }

    notifyListeners();
  }

  Future clearAddressLogout(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString('address', '');
    preferences.setString('addresstitle', '');
    preferences.setString('addresstitid', '');
    showAddress.title = '';
    showAddress.address = '';
    checkidLogin = '';
    listAddress = [];
    model?.result?.addressBook = [];
  }

  Future getCurrentLocation(
      {String? flag, required BuildContext context}) async {
    if (flag == 'search') {
      Navigator.pop(context);
      textFieldError[2] = '';
      notifyListeners();
    } else if (flag == 'logout') {
      listAddress = [];
    }
    try {
      userLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      //set latlong for use to menudetail and searches
      showAddress.longitude = userLocation!.longitude.toString();
      showAddress.latitude = userLocation!.latitude.toString();
      notifyListeners();

      var preferences = await SharedPreferences.getInstance();
      var body = {
        "latitude": userLocation!.latitude.toString(),
        "longitude": userLocation!.longitude.toString()
      };

      await RestAPI()
          .getData(
        url: ApiPath.getLocation,
        body: body,
      )
          .then(
        (value) async {
          locaModel = GetLocationModel.fromJson(value);

          if (flag == 'search') {
            textController[2].text =
                showAddress.address = locaModel!.result!.address!;
            getMainAddress();
          } else {
            showAddress.title = 'ที่อยู่ปัจจุบัน';
            showAddress.address = locaModel!.result!.address!;
            getMainAddress();
            await preferences.setString('address', showAddress.address);

            if (flag != 'logout') {
              Provider.of<RestaurantMainProvider>(context, listen: false)
                  .getDataListMenuMain(
                      flagPage: 'MainFlagment', context: context);
            }
          }

          notifyListeners();
        },
      );
    } on Exception catch (exception, stackTrace_ex) {
      Constants()
          .printColorRed('ErrorOnExceptionFromgetCurrentLocation:: $exception');
      Constants().printColorRed('check stack error :  $stackTrace_ex');
    } catch (error, stackTrace) {
      Constants().printColorRed('ErrorFromgetCurrentLocation:: $error');
      Constants().printColorRed('check stack error :  $stackTrace');
    }
  }

  void getActionPage(
    BuildContext context,
    String action, {
    int? index,
  }) {
    flagAction = action;
    if (flagAction == 'edit' || flagAction == 'editByAddressSelected')
      editAddressAction(index!);

    notifyListeners();
    Navigator.pushNamed(context, '/addAddressPage');
  }

  onSelectTypeFoodButton(val, int index) {
    //เลือกที่อยู่ที่่จะเพิ่ม
    groupData.forEach((element) => element.selected = false);
    groupValue = val as int;
    groupData[index].selected = true;

    textController[1].text = '';
    textController[2].text = '';
    textController[0].text =
        groupData[index].text == 'อื่นๆ' ? '' : groupData[index].text;

    notifyListeners();
  }

  checkinitDataAddress() {
    int _indexVal = 0;
    textController[1].text = '';
    textController[2].text = '';
    stsEtc = true;
    stsHome = true;
    stsOffice = true;

    listAddress!.forEach((element) {
      if (element.title == 'Home' || element.title == 'บ้าน') {
        //ถ้าบ้้านมีข้อมูลให้ hidden บ้านและโชว์ที่อยู่
        stsHome = false;
        _indexVal = 1;
      }
      if (element.title == 'Office' || element.title == 'ออฟฟิศ') {
        //ถ้าบที่มีข้อมูลให้ hidden ที่อยู่และโชว์บ้าน
        stsOffice = false;
        _indexVal = 0;
      }
    });
    //ถ้ามีทั้งคู่ให้โชว์แค่ other
    if (!stsHome && !stsOffice) _indexVal = 2;

    showDefTypeAddress(_indexVal);
  }

  showDefTypeAddress(int index) {
    //เช็คการโชว์ button ว่าต้องโชว์อันไหนบ้าง
    groupData.forEach((element) {
      element.selected = false;
    });
    groupValue = index;
    groupData[index].selected = true;

    textController[0].text =
        groupData[index].text == 'อื่นๆ' ? '' : groupData[index].text;

    notifyListeners();
  }

  bool checkHideVisible(int index) {
    bool _visible = true;
    if (groupData[index].text == 'บ้าน')
      _visible = stsHome;
    else if (groupData[index].text == 'ออฟฟิศ')
      _visible = stsOffice;
    else if (groupData[index].text == 'อื่นๆ') _visible = stsEtc;

    return _visible;
  }

  textFieldOnchange(int index) {
    textFieldError[index] = '';
    notifyListeners();
  }

  Future checkActionSubmit(BuildContext context) async {
    List<bool> _checkStatusEmply = [false, false, false];
    if (textController[0].text.isEmpty || textController[0].text.trim() == '') {
      _checkStatusEmply[0] = false;
      textFieldError[0] = 'กรุณากรอกชื่อที่อยู่';
    } else {
      textFieldError[0] = '';
      _checkStatusEmply[0] = true;
    }

    if (textController[1].text.isEmpty || textController[1].text.trim() == '') {
      _checkStatusEmply[1] = false;
      textFieldError[1] = 'กรุณากรอกบ้านเลขที่';
    } else {
      textFieldError[1] = '';
      _checkStatusEmply[1] = true;
    }

    if (textController[2].text.isEmpty || textController[2].text.trim() == '') {
      _checkStatusEmply[2] = false;
      textFieldError[2] = 'กรุณากรอกที่อยู่';
    } else {
      textFieldError[2] = '';
      _checkStatusEmply[2] = true;
    }

    notifyListeners();
    if (_checkStatusEmply[0] && _checkStatusEmply[1] && _checkStatusEmply[2]) {
      //เช็คปุ่ม submit ว่าเพิ่มหรือแก้ไข
      if (flagAction == 'add') {
        await adddAddress();
        await getAddress(context);
        Navigator.pop(context);
      } else if (flagAction == 'edit') {
        await editAddress();
        await getAddress(context);

        Navigator.popUntil(context, ModalRoute.withName('/addressSave'));
      } else if (flagAction == 'editByAddressSelected') {
        await editAddress();
        await getAddress(context);

        Navigator.popUntil(context, ModalRoute.withName('/addressSelected'));
      }
    }
  }

  editAddressAction(int index) {
    // ตอนคลิีก eidit แล้วส่งค่าตาม index มาโชว์
    if (listAddress![index].title == 'บ้าน' ||
        listAddress![index].title == 'Home') {
      groupValue = 0;
      stsHome = true;
      stsOffice = false;
      stsEtc = false;
    } else if (listAddress![index].title == 'ออฟฟิศ' ||
        listAddress![index].title == 'Office') {
      groupValue = 1;
      stsOffice = true;
      stsHome = false;
      stsEtc = false;
    } else {
      groupValue = 2;
      stsEtc = true;
      stsOffice = false;
      stsHome = false;
    }
    indexAddressEdit = index;
    idAdressEdit = listAddress![index].id.toString();
    textController[0].text = listAddress![index].title.toString();
    textController[1].text = listAddress![index].flatNo.toString();
    textController[2].text = listAddress![index].address.toString();

    notifyListeners();
  }

  deleteAction(BuildContext context, int index) {
    if (showAddress.id == model!.result!.addressBook![index].id.toString()) {
      Navigator.pop(context);
      normalDialog(context, 'ไม่สามารถลบที่อยู่ที่ทำการเลือกไว้อยู่ได้',
          text: 'ปิด');
    } else {
      //ลบข้อมูลพร้อมเปลี่ยน status
      if (listAddress![index].title == 'บ้าน' ||
          listAddress![index].title == 'Home')
        stsHome = true;
      else if (listAddress![index].title == 'ออฟฟิศ' ||
          listAddress![index].title == 'Office') stsOffice = true;

      deleteAddress(listAddress![index].id.toString())
          .then((value) => getAddress(context));

      Navigator.pop(context);
    }
    //------------------ Google API Zone ------------------------------
  }

  initGooglePlace() {
    String apiKey = 'key google';
    //String apiKey = 'key google;
    googlePlace = GooglePlace(apiKey);
  }

  onChangeFocusColor(value) {
    colorTextAddressFocus = value ? Color(0xFFFEBC18) : Colors.black54;
    notifyListeners();
  }

  onTapSelectAddressGoogle(BuildContext context, int index) async {
    // var result =
    //     await this.googlePlace!.details.get(predictions[index].placeId!);
    // if (result != null && result.result != null) {
    //   detailsResult = result.result;
    //   textController[2].text = detailsResult!.formattedAddress!;

    textController[2].text = predictions[index].description!;
    textFieldError[2] = '';
    notifyListeners();

    Navigator.pop(context);
    //  }
  }

  void onChangeSearch(value, mounted) {
    {
      if (value.isNotEmpty) {
        autoCompleteSearch(value, mounted);
      } else {
        if (predictions.length > 0 && mounted) {
          predictions = [];
          notifyListeners();
        }
      }
    }
  }

  void autoCompleteSearch(String value, mounted) async {
    var result = await googlePlace!.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      predictions = result.predictions!;

      notifyListeners();
    }
  }

  changeAddressSelect(
      BuildContext context, String value, String lat, String long) {
    textController[2].text = value;
    textFieldError[2] = '';

    latText = lat;
    lngText = long;
    notifyListeners();
    Navigator.pop(context);
    // Navigator.of(context).pop();
  }
}

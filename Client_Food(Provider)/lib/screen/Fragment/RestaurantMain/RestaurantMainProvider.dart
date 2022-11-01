import 'package:flutter/material.dart';
import 'package:/model/FromJSON/SearchesModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantMainProvider extends ChangeNotifier {
  RestaurantMainProvider();
  String foodType = 'ร้านอาหารใกล้เคียง', searchValue = '', cuiId = '';
  bool searchBarSts = false,
      checkData = false,
      loginSts = false,
      pageCategorySts = false,
      isScorolLoadMain = false,
      isScorolLoadType = false,
      isScorolLoadSearch = false,
      maxScorolLoadMain = false,
      maxScorolLoadType = false,
      maxScorolLoadSearch = false;
  int pageLoadMain = 1, pageLoadType = 1, pageLoadSearch = 1;
  SearchesModel? model;
  List<RestaurantLists> listRestDetail = [];
  List<RestaurantLists> listRestDetailType = [];
  List<RestaurantLists> listRestDetailSearch = [];
  List<AllCuisinesLists> allCuisinesLists = [];
  List<BannerLists> bannerList = [];
  TextEditingController fname = TextEditingController();

  SuccessModel? modelSuccess;
  int groupValue = 0;

  intitMainPage(
      {String? flagPage = 'MainFlagment',
      required BuildContext context}) async {
    var preferences = await SharedPreferences.getInstance();
    searchValue = '';
    isScorolLoadMain = false;
    isScorolLoadType = false;
    isScorolLoadSearch = false;
    maxScorolLoadMain = false;
    maxScorolLoadType = false;
    maxScorolLoadSearch = false;
    loginSts = preferences.getBool('stsLogin')!;
    pageLoadMain = 1;
    pageLoadType = 1;
    pageLoadSearch = 1;
    cuiId = '';
    if ((preferences.getString('address') != null && loginSts) ||
        flagPage == 'refrestData') {
      flagPage == 'refrestData'
          ? flagPage = 'MainFlagment'
          : flagPage = flagPage;
      getDataListMenuMain(flagPage: flagPage, context: context);
    }
  }

  refrestData(BuildContext context) {
    listRestDetail.clear();
    listRestDetailSearch.clear();
    listRestDetailType.clear();
    notifyListeners();

    intitMainPage(context: context, flagPage: 'refrestData');
  }

  Future getDataListMenuMain(
      {String? searchText,
      String? flagPage,
      required BuildContext context,
      String? typeFood,
      // String? location,
      String? latitude,
      String? longitude,
      bool slideLoad = false}) async {
    pageCategorySts = false;
    var preferences = await SharedPreferences.getInstance();
    searchValue = searchText ?? '';
    String _itemsPerpage = '';
    String _latitudeRest = latitude ??
        Provider.of<AddressSavePageProvider>(context, listen: false)
            .showAddress
            .latitude;
    String _longitudeRest = longitude ??
        Provider.of<AddressSavePageProvider>(context, listen: false)
            .showAddress
            .longitude;
    //get limit order

    try {
      await RestAPI().getData(url: ApiPath.configs, body: {
        "key": 'limit_store_storeproc'
      }).then((value) => _itemsPerpage = value['result']['value']);
    } catch (e) {
      debugPrint('print error limit_store_storeproc = $e');
      _itemsPerpage = "10";
    }

    int _countPage = flagPage == 'Search'
        ? pageLoadSearch
        : flagPage == 'TypeFood'
            ? pageLoadType
            : pageLoadMain;

    flagPage == 'SelectAddress' ? _countPage = 1 : _countPage = _countPage;

    var body = {
      // "searchLocation": location ?? preferences.getString('address'),
      "latitude": _latitudeRest,
      "longitude": _longitudeRest,
      "customer_id": preferences.getString('id') ?? '',
      "search_store": searchValue,
      "cuisines_id": typeFood ?? "",
      "items_perpage": _itemsPerpage,
      "pageno": _countPage
    };
    RestAPI().getData(url: ApiPath.searches, body: body).then((value) {
      modelSuccess = null;
      if (value['result']['success'].toString() == '1') {
        model = SearchesModel.fromJson(value);
        bannerList = model!.result!.bannerLists ?? [];
        checkData = true;

        if (slideLoad) {
          // slideLoading
          if (flagPage == 'MainFlagment') {
            pageLoadMain++;
            isScorolLoadMain = true;
            if (model!.result!.restaurantLists!.length > 0) {
              listRestDetail
                  .addAll(_listCusine(model!.result!.restaurantLists!));
            }
            if (model!.result!.restaurantLists!.length <
                int.parse(_itemsPerpage)) {
              isScorolLoadMain = false;
              maxScorolLoadMain = true;
            } else {
              isScorolLoadMain = true;
              maxScorolLoadMain = false;
            }
          }

          if (flagPage == 'TypeFood') {
            pageLoadType++;
            isScorolLoadType = true;
            if (model!.result!.restaurantLists!.length > 0) {
              listRestDetailType
                  .addAll(_listCusine(model!.result!.restaurantLists!));
            }
            if (model!.result!.restaurantLists!.length <
                int.parse(_itemsPerpage)) {
              isScorolLoadType = false;
              maxScorolLoadType = true;
            } else {
              isScorolLoadType = true;
              maxScorolLoadType = false;
            }
          }

          if (flagPage == 'Search') {
            if (model!.result!.restaurantLists!.length > 0) {
              listRestDetailSearch.addAll(model!.result!.restaurantLists!);
            }
            if (model!.result!.restaurantLists!.length <
                int.parse(_itemsPerpage)) {
              isScorolLoadSearch = false;
              maxScorolLoadSearch = true;
            } else {
              isScorolLoadSearch = true;
              maxScorolLoadSearch = false;
            }
          }
        } else {
          //first open page
          if (flagPage == 'MainFlagment' || flagPage == 'SelectAddress') {
            maxScorolLoadMain = false;
            pageLoadMain++;
            listRestDetail = model!.result!.restaurantLists!;
            listRestDetail = _listCusine(listRestDetail);
            listRestDetailType.clear();
            listRestDetailSearch.clear();

            //check load first น้อยกว่าค่าที่โหลดมาได้
            if (listRestDetail.length < int.parse(_itemsPerpage)) {
              isScorolLoadMain = false;
              maxScorolLoadMain = true;
            } else {
              isScorolLoadMain = true;
              maxScorolLoadMain = false;
            }
          }
          if (flagPage == 'TypeFood') {
            maxScorolLoadType = false;
            pageLoadType++;
            listRestDetailType = model!.result!.restaurantLists!;
            listRestDetailType = _listCusine(listRestDetailType);
            listRestDetailSearch.clear();

            //check load first น้อยกว่าค่าที่โหลดมาได้
            if (listRestDetailType.length < int.parse(_itemsPerpage)) {
              isScorolLoadType = false;
              maxScorolLoadType = true;
            } else {
              isScorolLoadType = true;
              maxScorolLoadType = false;
            }
          }

          if (flagPage == 'Search') {
            pageLoadSearch = 1;
            listRestDetailSearch = model!.result!.restaurantLists!;
            listRestDetailSearch = _listCusine(listRestDetailSearch);
            listRestDetailType.clear();

            //check load first น้อยกว่าค่าที่โหลดมาได้
            if (listRestDetailSearch.length < int.parse(_itemsPerpage)) {
              isScorolLoadSearch = false;
              maxScorolLoadSearch = true;
            } else {
              isScorolLoadSearch = true;
              maxScorolLoadSearch = false;
            }
          }
          if (flagPage != "Search") {
            //เพิ่ม catagory ดูทั้งหมด
            allCuisinesLists = model!.result!.allCuisinesLists!;
            allCuisinesLists.add(AllCuisinesLists(
                name: 'ดูทั้งหมด',
                colorImg: '#FEBC18',
                iconImg: '',
                id: 1,
                urlImg: ''));
          }
        }
      } else {
        //not data
        if (_countPage == 1) // ต้องเป็นการโหลดครั้งแรกเท่านั้น
        {
          checkData = false;
          model = SearchesModel.fromJson(value);
          if (flagPage == 'MainFlagment' || flagPage == 'SelectAddress') {
            isScorolLoadMain = false;
            maxScorolLoadMain = true;
            listRestDetail.clear();
          } else if (flagPage == 'TypeFood') {
            isScorolLoadType = false;
            maxScorolLoadType = true;
            listRestDetailType.clear();
          } else if (flagPage == 'Search') listRestDetailSearch.clear();

          if (flagPage != 'Search') {
            allCuisinesLists = model!.result!.allCuisinesLists ?? [];
            allCuisinesLists.add(AllCuisinesLists(
                name: 'ดูทั้งหมด',
                colorImg: '#FEBC18',
                iconImg: '',
                id: 1,
                urlImg: ''));
          }
        } else {
          //กรณีโหลดข้อมูลแล้วไม่เจอ
          if (flagPage == 'MainFlagment' || flagPage == 'SelectAddress') {
            isScorolLoadMain = false;
            maxScorolLoadMain = true;
          } else if (flagPage == 'TypeFood') {
            isScorolLoadType = false;
            maxScorolLoadType = true;
          } else if (flagPage == 'Search') {
            isScorolLoadSearch = false;
            maxScorolLoadSearch = true;
          }
        }
      }

      if (flagPage == 'SelectAddress') {
        Navigator.popUntil(context, ModalRoute.withName('/fragment'));
      }

      notifyListeners();
    });
  }

  List<RestaurantLists> _listCusine(List<RestaurantLists> _listData) {
    // เพิ่มเรื่อง cusine สีเหลืองๆ
    for (var i = 0; i < _listData.length; i++) {
      if (_listData[i].cuisineLists.toString().contains(',')) {
        _listData[i].listCuisine = _listData[i].cuisineLists!.split(',');
      } else {
        _listData[i].listCuisine = [];
        _listData[i].listCuisine.add(_listData[i].cuisineLists!);
      }
    }

    return _listData;
  }

  scorllLoading(String flagPage, BuildContext context) {
    if (flagPage == 'MainFlagment')
      isScorolLoadMain = false;
    else if (flagPage == 'TypeFood')
      isScorolLoadType = false;
    else if (flagPage == 'Search') {
      pageLoadSearch++;
      isScorolLoadSearch = false;
    }

    notifyListeners();

    getDataListMenuMain(
        context: context,
        slideLoad: true,
        flagPage: flagPage,
        searchText: flagPage == 'Search' ? searchValue : '',
        typeFood: flagPage == 'TypeFood' ? cuiId : '');
  }

  Future updateFavorite(String storeId, String status) async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "updateFavorite",
      "store_id": storeId,
      "customer_id": preferences.getString('id'),
      "status": status
    };

    RestAPI().getData(url: ApiPath.updateFavorite, body: body);
    notifyListeners();
  }

  void changeStatusfavourite(int index, String flagPage) {
    String _id = '';
    String _favourite = '';
    //เช็คการเปลี่ยนStatus ของแต่ละหน้า
    if (flagPage == 'MainFlagment') {
      if (listRestDetail[index].favourite == '0') {
        listRestDetail[index].favourite = '1';
      } else {
        listRestDetail[index].favourite = '0';
      }
      _id = listRestDetail[index].id.toString();
      _favourite = listRestDetail[index].favourite.toString();
    } else if (flagPage == 'TypeFood') {
      if (listRestDetailType[index].favourite == '0') {
        listRestDetailType[index].favourite = '1';
      } else {
        listRestDetailType[index].favourite = '0';
      }
      _id = listRestDetailType[index].id.toString();
      _favourite = listRestDetailType[index].favourite.toString();
    } else if (flagPage == 'Search') {
      _id = listRestDetailSearch[index].id.toString();
      if (listRestDetailSearch[index].favourite == '0') {
        listRestDetailSearch[index].favourite = '1';
      } else {
        listRestDetailSearch[index].favourite = '0';
      }
      _id = listRestDetailSearch[index].id.toString();
      _favourite = listRestDetailSearch[index].favourite.toString();
    }

    notifyListeners();

    updateFavorite(_id, _favourite);
  }

  onClickFoodType(BuildContext context, String data, String cuiIdData) {
    foodType = data;
    listRestDetailType = [];
    pageLoadType = 1;
    cuiId = cuiIdData;
    getDataListMenuMain(
        context: context, typeFood: cuiId, flagPage: 'TypeFood');
    Navigator.pushNamed(context, '/selectTypeFood');
  }

  onClickSearchBar(BuildContext context) {
    pageLoadSearch = 1;
    isScorolLoadSearch = true;
    maxScorolLoadSearch = false;
    fname.text = '';
    searchBarSts = !searchBarSts;
    listRestDetailSearch = [];
    Navigator.pushNamed(context, '/searchPage');

    notifyListeners();
  }

  void closeTabSearch(BuildContext context) {
    searchBarSts = !searchBarSts;
    fname.text = '';
    listRestDetailSearch = [];
    Navigator.pushReplacementNamed(context, '/fragment');
    notifyListeners();

    getDataListMenuMain(flagPage: 'MainFlagment', context: context);
  }

  void clearTabSearch(BuildContext context) {
    fname.text = '';
    listRestDetailSearch = [];
    notifyListeners();
    //  getDataListMenuMain(flagPage: 'Search');
  }

  void changePageCategorySts(bool status) {
    pageCategorySts = status;
    notifyListeners();
  }

  int colorCategory(int index) {
    if (allCuisinesLists[index].colorImg! != '')
      return int.parse(
          allCuisinesLists[index].colorImg!.replaceAll('#', '0xFF'));
    else
      return 0xFFFFFFFF;
  }
}

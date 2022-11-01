import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../AddressSavePageProvider.dart';

class AddAddressPage extends StatefulWidget {
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  @override
  _AddAddressPage createState() => _AddAddressPage();
}

class _AddAddressPage extends State<AddAddressPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddressSavePageProvider>(context, listen: false)
        .getAddress(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AddressSavePageProvider, BasketPageProvider>(
      builder: (context, pvd, pvdBasket, child) => WillPopScope(
        onWillPop: () {
          if (pvd.flagAction == 'edit')
            Navigator.popUntil(context, ModalRoute.withName('/addressSave'));
          else if (pvd.flagAction == 'editByAddressSelected') {
            Navigator.popUntil(
                context, ModalRoute.withName('/addressSelected'));
          } else
            Navigator.pop(context);

          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Constants().leadingBackIconAppBar(context, onPressed: () {
              if (pvd.flagAction == 'edit')
                Navigator.popUntil(
                    context, ModalRoute.withName('/addressSave'));
              else if (pvd.flagAction == 'editByAddressSelected') {
                Navigator.popUntil(
                    context, ModalRoute.withName('/addressSelected'));
              } else
                Navigator.pop(context);
            }),
            centerTitle: false,
            title: Constants().fontStyleBold(
                pvd.flagAction == 'add' ? 'เพิ่มที่อยู่' : 'แก้ไขที่อยู่',
                fontSize: 21),
            flexibleSpace: Constants().flexibleSpaceInAppBar(),
          ),
          body: Padding(
            padding: Constants.paddingAppLRTB,
            child: Column(
              children: [
                Row(
                  children: List.generate(
                    pvd.groupData.length,
                    (index) => Visibility(
                        visible: pvd.checkHideVisible(index),
                        child: raidioButton(index)),
                  ),
                ),
                Visibility(
                    visible: pvd.groupValue == 2 ? true : false,
                    child: textFieldRow('ชื่อของที่อยู่', 0)),
                textFieldRow('บ้านเลขที่', 1),
                textFieldRow('ที่อยู่', 2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ButtonAccept(
                    onPressed: () async {
                      //เงื่อนไขต้องมีออเดอร์และเป็นทำการแก้ไขและเป็นที่อยู่ที่ใช้ในการส่งออเดอร์
                      if ((pvdBasket.placeOrderModel.deliveryId != '' &&
                              pvdBasket.placeOrderModel.deliveryId != null) &&
                          (pvd.flagAction == 'editByAddressSelected' ||
                              pvd.flagAction == 'edit' &&
                                  (pvdBasket.placeOrderModel.deliveryId ==
                                      pvd.model!.result!
                                          .addressBook![pvd.indexAddressEdit].id
                                          .toString()))) {
                        Constants().dialogProgress(context);
                        await pvd.getDataSearch(
                            pvd.latText,
                            pvd.lngText,
                            pvdBasket.model.latitudeRest!,
                            pvdBasket.model.longitudeRest!);

                        if (pvd.checkChangeAdress) {
                          await pvd.checkActionSubmit(context);
                          await pvd.selectAddress(pvd.indexAddressEdit);
                          pvdBasket.onChangeAddressSubmit(
                            context: context,
                            addressId: pvd.showAddress.id,
                            addressTitle: pvd.showAddress.title,
                            latitude: pvd.model!.result!
                                .addressBook![pvd.indexAddressEdit].latitude,
                            longtitude: pvd.model!.result!
                                .addressBook![pvd.indexAddressEdit].longitude,
                          );
                        } else {
                          // fail location use
                          checkFailLocationChange(context);
                        }
                      } else if ((pvd.flagAction == 'editByAddressSelected' ||
                          pvd.flagAction == 'edit' &&
                              (pvd.showAddress.id ==
                                  pvd.model!.result!
                                      .addressBook![pvd.indexAddressEdit].id
                                      .toString()))) {
                        await pvd.checkActionSubmit(context);
                        pvd.selectAddress(pvd.indexAddressEdit);
                      } else
                        pvd.checkActionSubmit(context);
                    },
                    text: 'ยืนยัน',
                    fontColor: Colors.white,
                    backgroundColor: Color(0xFFFEBC18),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    fontStyleRegular: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget raidioButton(int index) {
    return Consumer<AddressSavePageProvider>(
      builder: (context, pvd, child) => Expanded(
        flex: 2,
        child: RadioListTile(
          contentPadding: EdgeInsets.all(0),
          toggleable: false,
          dense: true,
          value: index,
          groupValue: pvd.groupValue,
          selected: pvd.groupData[index].selected,
          onChanged: (val) => pvd.onSelectTypeFoodButton(val, index),
          activeColor: Colors.amber,
          title: Constants().fontStyleRegular(
            ' ${pvd.groupData[index].text}',
            colorValue:
                pvd.groupData[index].selected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget textFieldRow(String hintText, int index, {String? flag}) {
    return Consumer<AddressSavePageProvider>(
      builder: (_, pvd, child) => TextFormField(
        controller: pvd.textController[index],
        keyboardType: TextInputType.text,
        onChanged: (String onchange) => pvd.textFieldOnchange(index),
        onTap: () {
          if (hintText == 'ที่อยู่') {
            Navigator.pushNamed(context, '/searchAdress');

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return PlacePicker(
            //         apiKey: 'key google',
            //         hintText: "Find a place ...",
            //         searchingText: "Please wait ...",
            //         selectText: "Select place",
            //         outsideOfPickAreaText: "Place not in area",
            //         initialPosition:
            //             AddAddressPage.kInitialPosition, // location bts siam,
            //         useCurrentLocation: true,
            //         selectInitialPosition: true,
            //         usePinPointingSearch: true,
            //         usePlaceDetailSearch: true,
            //         autocompleteLanguage: "th",
            //         region: 'sea',
            //         onPlacePicked: (PickResult result) {
            //           debugPrint('get lat lng');
            //           debugPrint('${result.geometry!.location.lat}');
            //           debugPrint('${result.geometry!.location.lng}');

            //           Provider.of<AddressSavePageProvider>(context,
            //                   listen: false)
            //               .changeAddressSelect(
            //                   context, result.formattedAddress.toString());
            //         },
            //       );
            //     },
            //   ),
            // );
          }
        },
        decoration: InputDecoration(
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: pvd.textFieldError[index].isEmpty
                    ? Color(0xFFFEBC18)
                    : Colors.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: pvd.textFieldError[index].isEmpty
                    ? Color(0xFFFEBC18)
                    : Colors.red),
          ),
          errorText: pvd.textFieldError[index],
          contentPadding: EdgeInsets.fromLTRB(5.0, 20.0, 20.0, 0),
          counterText: "",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFEBC18)),
          ),
          hintText: hintText,
          hintStyle:
              Constants().textStyleRegular(colorValue: Color(0xFFC0C0C0)),
        ),
      ),
    );
  }

  checkFailLocationChange(BuildContext context) {
    Constants().dialogProgress(context, pop: true);
    normalDialog(
        context, 'ที่อยู่การจัดส่งไม่อยู่ในพื้นที่ กรุณาเลือกที่อยู่จัดส่งใหม่',
        text: 'ปิด');
  }
}

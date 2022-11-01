import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/screen/Profile/provider/ProfileCustomerProvider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/Constants.dart';
import '../../FragmentProvider.dart';

AppBar appBarMain(BuildContext context, {String? photoURL}) {
  photoURL ??= '';

  return AppBar(
    flexibleSpace: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF3D525C),
      ),
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color(0xFF3D525C),
    ),
    toolbarHeight: 80,
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xFF3D525C),
    bottomOpacity: 0.0,
    elevation: 0.0,
    title: SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          addressBar(),
          accoutBar(context),
        ],
      ),
    ),
  );
}

Widget accoutBar(BuildContext context) {
  var constants = Constants();
  return Consumer2<FragmentProvider, ProfileCustomerProvider>(
    builder: (context, pvdFragment, pvdProfile, child) => Visibility(
      visible: pvdProfile.model != null,
      child: InkWell(
        onTap: () {
          // Navigator.popUntil(context, ModalRoute.withName('/fragment'));

          // pvdFragment.changeIndexpage(4);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.325,
          color: Color(0xFF3D525C),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(flex: 4, child: constants.contactMainPageSVG()),
                Visibility(
                  visible: pvdProfile.nameUser.toString().isNotEmpty ||
                      !pvdFragment.stsSigin,
                  child: Flexible(
                    flex: 6,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          constants.fontStyleRegular(
                              pvdFragment.stsSigin ? 'สวัสดี' : 'กรุณา',
                              colorValue: Color(0xFFFEBC18),
                              fontSize: 16.5),
                          constants.fontStyleBold(
                              pvdFragment.stsSigin
                                  ? pvdProfile.nameUser
                                  : 'เข้าสู่ระบบ',
                              overflow: TextOverflow.visible,
                              colorValue: Color(0xFFFEBC18),
                              fontSize: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget addressBar() {
  var constants = Constants();
  return Consumer4<AddressSavePageProvider, FragmentProvider,
      RestaurantMainProvider, BasketPageProvider>(
    builder: (context, pvd, pvdFragment, pvdRest, pvdBasket, child) =>
        Visibility(
      visible: pvd.showAddress.title == '' ? false : true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Visibility(
            visible: pvdRest.pageCategorySts,
            child: InkWell(
                onTap: () {
                  pvdRest.changePageCategorySts(false);
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
          ),
          InkWell(
            onTap: () {
              if (pvdFragment.stsSigin) {
                pvdBasket.openbyCheckoutPageSts(false);
                Navigator.pushNamed(context, '/addressSelected');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Color(0xFFFEBC18), size: 28),
                SizedBox(
                  width: pvdRest.pageCategorySts
                      ? MediaQuery.of(context).size.width * 0.315
                      : MediaQuery.of(context).size.width * 0.425,
                  child: pvd.addressPageMain[1] == ' - '
                      ? constants.fontStyleBold(pvd.addressPageMain[0],
                          fontSize: 16.5,
                          colorValue: Color(0xFFFEBC18),
                          overflow: TextOverflow.ellipsis)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                constants.fontStyleBold(
                                    pvdFragment.stsSigin &&
                                            pvd.showAddress.title.toString() ==
                                                'ที่อยู่ปัจจุบัน'
                                        ? 'ที่อยู่ใหม่'
                                        : pvd.showAddress.title.toString(),
                                    fontSize: 16.5,
                                    colorValue: Color(0xFFFEBC18),
                                    overflow: TextOverflow.ellipsis),
                                Visibility(
                                  visible: pvd.showAddress.title.toString() ==
                                          'ที่อยู่ปัจจุบัน' &&
                                      pvdFragment.stsSigin,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Icon(Icons.add,
                                        size: 10, color: Color(0xFFFEBC18)),
                                  ),
                                )
                              ],
                            ),
                            constants.fontStyleRegular(
                                pvd.showAddress.address.toString(),
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16.5,
                                colorValue: Colors.white),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

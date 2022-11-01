import 'package:flutter/material.dart';
import 'package:/screen/Fragment/Account/provider/AccountProvider.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:/screen/Fragment/Account/Authen/provider/RigisterProvider.dart';

import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../RestaurantMain/RestaurantMainProvider.dart';

class Account extends StatefulWidget {
  @override
  _Account createState() => _Account();
}

class _Account extends State<Account> {
  Future<void>? launched;

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();

    return Scaffold(
        appBar: AppBar(
          title: constants.fontStyleBold('บัญชี', fontSize: 23),
          flexibleSpace: constants.flexibleSpaceInAppBar(),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
                margin: const EdgeInsets.all(0),
                color: Color(0xFFF3F3F3),
                child: Padding(
                  padding: Constants.paddingAppLRTB,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: boxContainer(
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rowAccountDetail(IconImport.accounticon,
                                    'ข้อมูลส่วนตัว', context),
                                rowAccountDetail(Icons.notifications,
                                    'การแจ้งเตือน', context),
                                rowAccountDetail(IconImport.location,
                                    'บันทึกที่อยู่', context),
                                rowAccountDetail(IconImport.heart,
                                    'ร้านค้าที่ถูกใจ', context),
                                rowAccountDetail(
                                    Icons.lock, 'เปลี่ยนรหัสผ่าน', context),
                                rowAccountDetail(IconImport.ticketicon,
                                    'คะแนนสะสม', context),
                                // rowAccountDetail(Icons.person_add_alt_sharp,
                                //     'แนะนำเพื่อน', context),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: boxContainer(
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rowAccountDetail(Icons.auto_stories_sharp,
                                    'เงื่อนไขและข้อตกลง', context),
                                rowAccountDetail(
                                    Icons.info, 'เกี่ยวกับเรา', context),
                                rowAccountDetail(
                                    Icons.announcement, 'FAQ', context),
                                rowAccountDetail(Icons.headset_mic,
                                    'โทรหา Call Center', context),
                              ]),
                        ),
                      ),
                      Consumer2<AddressSavePageProvider,
                          RestaurantMainProvider>(
                        builder: (context, pvdAddrs, pvdRestmain, child) =>
                            Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: InkWell(
                              onTap: () {
                                //logOutDialog(context);

                                normalDialog(
                                  context,
                                  'คุณต้องการออกจากระบบหรือไม่',
                                  dialogYesNo: true,
                                  onPressed: () async {
                                    await Provider.of<RegisterProvider>(context,
                                            listen: false)
                                        .sendSignOutAPI(context);

                                    print('||||| ACTION AFTER LOG OUT ||||');
                                    //    print('||||| $value ||||');
                                    await Provider.of<BasketPageProvider>(
                                            context,
                                            listen: false)
                                        .clearDataMenuOrder(context,
                                            logoutSts: true);

                                    await pvdAddrs.clearAddressLogout(context);
                                    await pvdAddrs.getCurrentLocation(
                                        context: context, flag: 'logout');
                                    print(
                                        'checter ssssssssssss${pvdAddrs.showAddress.address}');
                                    pvdRestmain.getDataListMenuMain(
                                      context: context,
                                      latitude: pvdAddrs.showAddress.latitude,
                                      longitude: pvdAddrs.showAddress.longitude,
                                      flagPage: 'MainFlagment',
                                      // location: pvdAddrs.showAddress.address
                                    );
                                  },
                                );
                              },
                              child: boxContainer(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: constants.fontStyleBold(
                                          'ออกจากระบบ',
                                          fontSize: 21),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Consumer<FragmentProvider>(
                        builder: (context, pvd, child) => Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 22.0),
                          child: constants.fontStyleRegular(
                              ApiPath().isGolive
                                  ? 'เวอร์ชั่น ${pvd.versionText}'
                                  : 'เวอร์ชั่น ${pvd.versionText}_${ApiPath.routeEndpoint}',
                              fontSize: 16.5),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }

  Widget boxContainer(Widget rowData) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(1, 3),
              blurRadius: 2,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFFFFFFF),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6),
          child: rowData,
        ));
  }

  Widget rowAccountDetail(IconData icon, String value, BuildContext context) {
    var constants = Constants();
    return Consumer<AccountProvider>(
      builder: (context, pvd, child) => InkWell(
        onTap: () => {pvd.routePage(value, context)},
        child: Padding(
          padding: Constants.paddingAppLRTB,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                child: Row(
                  children: [
                    Icon(icon, size: 17),
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: constants.fontStyleBold(value,
                            fontSize: 21, colorValue: Color(0xFF7A7A7A))),
                  ],
                ),
              ),
              value == 'โทรหา Call Center'
                  ? Text('')
                  : Icon(Icons.arrow_forward_ios,
                      color: Color(0xFF3D525C), size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> phoneCallCenter(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

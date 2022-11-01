import 'package:flutter/material.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/utils/DialogsCallCenter.dart';
import 'package:provider/provider.dart';

class AccountProvider extends ChangeNotifier {
  AccountProvider();

  routePage(String page, BuildContext context) {
    var globalURLProvider =
        Provider.of<GlobalURLProvider>(context, listen: false);
    String routePage = '';
    switch (page) {
      case 'ข้อมูลส่วนตัว':
        routePage = 'profile';
        break;
      case 'การแจ้งเตือน':
        routePage = 'showNoticPage';
        break;
      case 'บันทึกที่อยู่':
        routePage = 'addressSave';
        break;
      case 'ร้านค้าที่ถูกใจ':
        routePage = 'favoriteShop';
        break;
      case 'เปลี่ยนรหัสผ่าน':
        routePage = 'changePassword';
        break;
      case 'คะแนนสะสม':
        routePage = 'accumulatedPoints';
        break;
      case 'แนะนำเพื่อน':
        routePage = 'referFriend';
        break;
      case 'เงื่อนไขและข้อตกลง':
        globalURLProvider.launchURL(
            context, '${globalURLProvider.termsPolicies}');
        break;
      case 'เกี่ยวกับเรา':
        globalURLProvider.launchURL(context, '${globalURLProvider.urlAboutUS}');
        break;
      case 'FAQ':
        globalURLProvider.launchURL(context, globalURLProvider.fAQcustomer);
        break;
      case 'โทรหา Call Center':
        phoneCallDialog(context, 'โทรหา Call Center');
        break;
      default:
    }

    if (routePage != '') return Navigator.pushNamed(context, '/$routePage');
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/MenuOrder/MenuOrderProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FragmentProvider extends ChangeNotifier {
  FragmentProvider();

  bool stsFlagButton = true;

  int currentIndex = 0;

  bool stsSigin = false;
  String versionText = '';

  late StreamSubscription<bool> keyboardSubscription;

  initKeyboardCheckBasketIcon() {
    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) async {
      if (visible == false)
        await Future.delayed(const Duration(milliseconds: 100));
      stsFlagButton = !visible;
      notifyListeners();
    });
  }

  disposeKeyBoardSigninPage() {
    keyboardSubscription.cancel();
  }

  intitdata(BuildContext context) async {
    stsFlagButton = true;
    var preferences = await SharedPreferences.getInstance();

    stsSigin = preferences.getBool('stsLogin') ?? false;

    // String phoneNo = preferences.getString('phone').toString();
    // if (phoneNo.isEmpty) {
    //   // Navigator.pushNamed(context, '/profile');
    //   Provider.of<RegisterProvider>(context, listen: false)
    //       .sendSignOutAPI(context);
    // }

    versionText = preferences.getString('version')!;
    notifyListeners(); // set this noti for version text in ui
  }

  Future initSigin(BuildContext context) async {
    Provider.of<GlobalURLProvider>(context, listen: false).noticUnreadAPI();

    var preferences = await SharedPreferences.getInstance();
    preferences.setBool('stsLogin', true);
    stsSigin = true;
    currentIndex = 0;

    notifyListeners();

    await Provider.of<AddressSavePageProvider>(context, listen: false)
        .getAddress(context);
  }

  Future initSigninSocail(context) async {
    Provider.of<GlobalURLProvider>(context, listen: false).noticUnreadAPI();

    var preferences = await SharedPreferences.getInstance();
    preferences.setBool('stsLogin', true);
    stsSigin = true;
    currentIndex = 0;
    notifyListeners();

    await Provider.of<AddressSavePageProvider>(context, listen: false)
        .getAddress(context);
  }

  Future onClickSingout(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setBool('stsLogin', false);
    preferences.setString('id', '');
    preferences.setString('custDeviceId', ''); //recheck again
    preferences.setString('phone', '');
    currentIndex = 0;
    stsSigin = false;

    notifyListeners();
  }

  openBasketPage(BuildContext context) {
    if (stsSigin == false) {
      normalDialog(context, 'กรุณา Login ก่อน', onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName('/fragment'));
        currentIndex = 4;
        notifyListeners();
      });
    } else {
      Navigator.popUntil(context, ModalRoute.withName('/fragment'));
      currentIndex = 2;
      notifyListeners();
    }
  }

  changeIndexpage(int index, {BuildContext? context}) {
    //change page ตาม index
    if (context != null)
      Provider.of<MenuOrderProvider>(context, listen: false)
          .checkIndxForRecursOrdr(index);

    currentIndex = index;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:project_test/pages/register/RigisterStep1Page.dart';
import 'package:project_test/pages/register/RigisterStep2Page.dart';

class RegisterProvider extends ChangeNotifier {
  int? currentTitle;
  Widget? currentPageWidget;
  RegisterProvider();

  init() {
    currentTitle = 0;
    setPage(currentTitle!);
  }

  setPage(int page) {
    currentTitle = page;
    if (page == 1) {
      currentPageWidget = RegisterStep1Page();
    } else if (page == 2) {
      currentPageWidget = RegisterStep2Page();
    } else if (page == 3) {
      currentPageWidget = RegisterStep2Page();
    } else if (page == 4) {
      currentPageWidget = RegisterStep2Page();
    } else {
      currentPageWidget = RegisterStep1Page();
    }
    notifyListeners();
  }
}

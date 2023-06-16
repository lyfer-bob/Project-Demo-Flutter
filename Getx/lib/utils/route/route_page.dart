import 'package:project/bindings/demo_binding.dart';
import 'package:project/screens/demo/demo_page.dart';
import 'package:project/screens/login/login.dart';
import 'package:project/bindings/login_binding.dart';
import 'package:project/screens/menu/components/story.dart';
import 'package:project/screens/menu/menu_page.dart';
import 'package:get/get.dart';
import 'package:project/bindings/menu_binging.dart';

class SDBRoutes {
  SDBRoutes._();

  static const String home = '/loginPage';
  static const String testScreen = '/testScreen';
  static const String menuPage = '/menuPage';
  static const String story = '/story';
  static const String demo = '/demo';
}

class SDBPages {
  SDBPages._();

  static final pages = [
    GetPage(
      name: SDBRoutes.home,
      page: () => LoginPages(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: SDBRoutes.menuPage,
      page: () => MenuPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: SDBRoutes.story,
      page: () => StoryPage(),
    ),
    GetPage(
      name: SDBRoutes.demo,
      page: () => DemoPage(),
      binding: DemoBinding(),
    ),
  ];
}

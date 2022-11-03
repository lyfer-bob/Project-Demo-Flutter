import 'package:project/page/login/login.dart';
import 'package:project/controllers/login/login_binding.dart';
import 'package:project/page/menu/components/story.dart';
import 'package:project/page/menu/menu_page.dart';
import 'package:get/get.dart';
import 'package:project/controllers/menu/menu_binging.dart';

class SDBRoutes {
  SDBRoutes._();

  static const String home = '/loginPaage';
  static const String testScreen = '/testScreen';
  static const String menuPage = '/menuPage';
  static const String story = '/story';
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
  ];
}

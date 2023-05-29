import 'package:get/get.dart';
import '../controllers/login/login_controller.dart';
import '../controllers/menu/menu_controller.dart';

Future<void> getInitService() async {
  Get.put(LoginController());
  Get.put(MenuCController());
}

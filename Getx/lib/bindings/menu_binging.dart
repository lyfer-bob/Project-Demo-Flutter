import 'package:get/instance_manager.dart';
import 'package:project/controllers/menu/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuCController>(() => MenuCController());
  }
}

import 'package:get/instance_manager.dart';
import 'package:project/controllers/demo/demo_controller.dart';

class DemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemoController>(() => DemoController());
  }
}

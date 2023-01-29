import 'package:get/instance_manager.dart';
import 'package:project/controllers/menu/menu_controller.dart';
import 'package:project/data/repositoryimp/menu_repositoryImp.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuController>(
      () => MenuController(
        repo: MenuRepositoryImp(),
      ),
    );
  }
}

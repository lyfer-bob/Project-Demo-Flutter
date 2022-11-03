import 'package:get/instance_manager.dart';
import 'package:project/data/repositoryiml/login_repositoryIml.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        repo: LoginRepositoryIml(),
      ),
    );
  }
  //   Get.lazyPut<LoginController>(() => LoginController());

}

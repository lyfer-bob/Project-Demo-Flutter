import 'package:get/instance_manager.dart';
import 'package:project/data/repositoryimp/login_repositoryImp.dart';
import '../controllers/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        repo: LoginRepositoryImp(),
      ),
    );
  }
}

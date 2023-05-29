import 'package:get/get.dart';
import 'package:project/data/login_repositoryImp.dart';


class DependencyCreator {
  static init() {
    Get.lazyPut(() => LoginRepository());
  }
}

import 'package:get/get.dart';
import 'package:project/data/repositoryimp/login_repositoryImp.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => LoginRepositoryImp());
  }
}

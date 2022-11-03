import 'package:get/get.dart';
import 'package:project/data/repositoryiml/login_repositoryIml.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => LoginRepositoryIml());
  }
}

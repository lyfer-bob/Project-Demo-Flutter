import 'package:get/get.dart';
import 'package:project/data/repositoryiml/menu_repositoryIml.dart';

class MenuController extends GetxController {
  MenuRepositoryIml? repo;
  MenuController({this.repo});

  var ctr = MenuRepositoryIml();
  // Rx<ListBannerTopNModel?> listBannerTopNModel = (null).obs;

  var jj = 'Test Data Controller'.obs;

  init() {
    print('init Menu Controller ::::::::::::::::::::');
    print('${ctr.getDatatest(1, 2)}');
  }
}

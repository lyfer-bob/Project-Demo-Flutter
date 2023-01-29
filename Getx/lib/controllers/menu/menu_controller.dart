import 'package:get/get.dart';
import 'package:project/data/repositoryimp/menu_repositoryImp.dart';

class MenuController extends GetxController {
  MenuRepositoryImp? repo;
  MenuController({this.repo});

  var ctr = MenuRepositoryImp();
  // Rx<ListBannerTopNModel?> listBannerTopNModel = (null).obs;

  var jj = 'Test Data Controller'.obs;

  init() {
    print('init Menu Controller ::::::::::::::::::::');
    print('${ctr.getDatatest(1, 2)}');
  }
}

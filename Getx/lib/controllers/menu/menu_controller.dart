import 'package:get/get.dart';
import 'package:project/data/menu_repositoryImp.dart';

class MenuCController extends GetxController {
  MenuRepository? repo;

  var ctr = MenuRepository();
  // Rx<ListBannerTopNModel?> listBannerTopNModel = (null).obs;

  var jj = 'Test Data Controller'.obs;

  init() {
    print('init Menu Controller ::::::::::::::::::::');
    print('${ctr.getDatatest(1, 2)}');
  }
}

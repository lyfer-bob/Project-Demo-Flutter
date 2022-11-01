import 'package:flutter/material.dart';
import 'package:/model/FromJSON/FavoriteListModelNew.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteShopProvider extends ChangeNotifier {
  FavoriteShopProvider();

  String foodType = 'ร้านอาหารใกล้เคียง';
  List<RestaurantLists>? listRes;
  FavoriteListModelNew? favListModel;

  changeStatusfavourite(int index) {
    if (listRes![index].status == '1') {
      listRes![index].status = '0';
      // notifyListeners();
    }
    notifyListeners();
    updateFavorite(listRes![index].id.toString(), listRes![index].status!);
    getListFavorite();
  }

  Future updateFavorite(String storeId, String status) async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "updateFavorite",
      "store_id": storeId,
      "customer_id": preferences.getString('id'),
      "status": status
    };

    await RestAPI().getData(url: ApiPath.updateFavorite, body: body);
    notifyListeners();
  }

  initData() {
    listRes = null;
    getListFavorite();
  }

  Future getListFavorite() async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "favoriteList",
      "customer_id": preferences.getString('id')
    };
    await RestAPI()
        .getData(url: ApiPath.favoriteList, body: body)
        .then((value) {
      favListModel = FavoriteListModelNew.fromJson(value);
      listRes = favListModel!.result!.restaurantLists ?? [];
      notifyListeners();
    });
  }
}

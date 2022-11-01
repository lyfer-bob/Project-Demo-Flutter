import 'package:flutter/material.dart';
import 'package:/model/ModelView/BasketPageModel.dart';
import 'package:/model/FromJSON/MenuDetailsModel.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  MenuDetailsModel? modelMenu;
  RestDetails? restDetails;
  List<OrderListAll>? orderListAll;
  List<RecommendMenusList>? recommendMenusList;
  bool stsbottomsheet = false;
  String foodType = 'ร้านอาหารใกล้เคียง';
  String restIdScroll = '';
  String latitudeRest = '';
  String longtitudeRest = '';
  List<RestaurantMenus>? restListMenu;

  BasketPageModel modelBasket = new BasketPageModel();
  ScrollController scorllController = new ScrollController();
  AddressSavePageProvider addressPrvd = new AddressSavePageProvider();

  int lengthMenuList = 0, pageindex = 1;
  bool scrollLoading = true, successLoading = false;

  getRestaurantDetail(String restId, BuildContext context) {
    orderListAll = null;
    modelMenu = null;
    restDetails = null;
    recommendMenusList = [];
    restListMenu = [];
    restIdScroll = restId;
    scrollLoading = true;
    successLoading = false;
    pageindex = 1;
    latitudeRest = Provider.of<AddressSavePageProvider>(context, listen: false)
        .showAddress
        .latitude;
    longtitudeRest =
        Provider.of<AddressSavePageProvider>(context, listen: false)
            .showAddress
            .longitude;
    getLoadMenuAll(restIdScroll, context);
  }

  Future getLoadMenuAll(String restId, BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();

    var body = {
      "customer_id": preferences.getString('id'),
      "resId": restId,
      // "address": preferences.getString('address'),
      "latitude": latitudeRest,
      "longitude": longtitudeRest,
      "page_size": "10", // fix
      "page_index": pageindex
    };
    RestAPI().getData(url: ApiPath.menuDetails, body: body).then((value) async {
      modelMenu = MenuDetailsModel.fromJson(value);
      restDetails = modelMenu!.result!.restDetails!;
      recommendMenusList = modelMenu!.result!.recommendMenusList ?? [];
      restListMenu = modelMenu!.result!.restDetails!.restaurantMenus ?? [];
      if (modelMenu!.result!.orderListAll != null &&
          modelMenu!.result!.orderListAll!.length > 0) {
        scrollLoading = true;

        if (pageindex == 1) {
          orderListAll = modelMenu!.result!.orderListAll ?? [];
          pageindex++;
        } else {
          orderListAll!.addAll(modelMenu!.result!.orderListAll ?? []);
          pageindex++;
        }
      } else {
        scrollLoading = false;
      }

      for (var i = 0; i < restDetails!.reviews!.length; i++) {
        restDetails!.reviews![i].created = Constants().dateTimeTHFormat(
            dateTime: restDetails!.reviews![i].created.toString(),
            formatDate: "yyyy-MM-ddTHH:mm:ss+07:00",
            dateOnly: true);
      }
      if (modelMenu!.result!.offersDiscount!.offerStatus!)
        modelMenu!.result!.offersDiscount!.offerTo = Constants()
            .dateTimeTHFormat(
                dateTime: modelMenu!.result!.offersDiscount!.offerTo.toString(),
                formatDate: "yyyy-MM-ddTHH:00:00+00:00",
                dateOnly: true);

      notifyListeners();
    });
  }

  int getIndexMenuAll(int index) {
    int _index = index +
        orderListAll!
            .where((element) => element.recommendMenuStatus == '1')
            .length;
    return _index;
  }

  Future updateFavorite(String storeId, String status) async {
    var preferences = await SharedPreferences.getInstance();
    var body = {
      "action": "updateFavorite",
      "store_id": storeId,
      "customer_id": preferences.getString('id'),
      "status": status
    };

    RestAPI().getData(url: ApiPath.updateFavorite, body: body);
    notifyListeners();
  }

  initScorllController() {
    scorllController.addListener(() {
      if (scorllController.position.pixels <=
          scorllController.position.maxScrollExtent) {
        print('NEW DATA CALL');
        //  scrollListener();
      }
    });
  }

  void changeStatusfavourite() {
    if (restDetails!.favourite.toString() == '0')
      restDetails!.favourite = 1;
    else
      restDetails!.favourite = 0;
    notifyListeners();

    updateFavorite(
        restDetails!.id.toString(), restDetails!.favourite!.toString());
  }

  void changeStatusBottomSheet(bool value) {
    stsbottomsheet = value;
    notifyListeners();
  }

  bool checkcategoryName(index) {
    bool _status = true;
    if (index > 0) {
      if (orderListAll![index].categoryName.toString() ==
          orderListAll![index - 1].categoryName.toString())
        _status = false;
      else
        _status = true;
    }
    return _status;
  }
}

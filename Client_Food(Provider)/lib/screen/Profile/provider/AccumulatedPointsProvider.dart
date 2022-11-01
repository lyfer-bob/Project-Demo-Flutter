import 'package:flutter/material.dart';
import 'package:/model/FromJSON/RewardHistory.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccumulatedPointsProvider extends ChangeNotifier {
  AccumulatedPointsProvider();

  RewardHistory? model;
  List<CustomerPoints> listReward = [];

  initData() async {
    var preferences = await SharedPreferences.getInstance();
    var customerId = preferences.getString('id');
    var body = {"customer_id": customerId};
    RestAPI().getData(url: ApiPath.rewardHistory, body: body).then((value) {
      model = RewardHistory.fromJson(value);
      listReward = model!.result!.customerPoints!;
      notifyListeners();
      for (var i = 0; i < listReward.length; i++) {
        listReward[i].created =
            Constants().dateTimeTHFormat(dateTime: listReward[i].created);
      }
      print('shot t ${listReward[1].order}');
    });
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:/model/FromJSON/OrderListModel.dart';
import 'package:/model/FromJSON/SuccessModel.dart';
import 'package:/model/ToJSON/OrderReviewModel.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuOrderProvider extends ChangeNotifier {
  MenuOrderProvider();

  OrderReviewModel orderReview = new OrderReviewModel(
    driverRating: 0.0,
    rating: 0.0,
  );
  TextEditingController messageCont = new TextEditingController();
  OrderListModel? model;
  SuccessModel? modelSuccess;
  List<OrderLists>? listMenuOrder;
  int indexStsReview = 0;
  bool loadOrderRecurs = false;
  bool stsDelay = true;

  Future getOrdertList() async {
    var preferences = await SharedPreferences.getInstance();
    modelSuccess = null;
    var body = {
      "customer_id": preferences.getString('id'),
      "action": "MyAccount",
      "limit_top": "80",
      "page": "OrderList"
    };
    await RestAPI()
        .getData(url: ApiPath.orderList, body: body)
        .then((value) async {
      if (value['result']['success'].toString() == '1') {
        model = OrderListModel.fromJson(value);
        listMenuOrder = model!.result!.orderLists ?? [];
      } else {
        listMenuOrder = [];
        modelSuccess = SuccessModel.fromJson(value);
      }
      for (var i = 0; i < listMenuOrder!.length; i++) {
        // get Date and time convert

        listMenuOrder![i].orderDate = listMenuOrder![i].orderDate == null
            ? ''
            : Constants()
                .dateTimeTHFormat(dateTime: listMenuOrder![i].orderDate);
      }
      stsDelay = true;
      notifyListeners();
    });
  }

  initData(BuildContext context) async {
    debugPrint('recursive menu order');
    await getOrdertList(); // get order
    if (loadOrderRecurs && stsDelay) {
      // check recursive

      Future.delayed(const Duration(seconds: 3), () {
        stsDelay = false;
        if (loadOrderRecurs) initData(context);
      });
    }
  }

  checkIndxForRecursOrdr(int index) {
    index == 1 ? loadOrderRecurs = true : loadOrderRecurs = false;
    notifyListeners();
  }

  Future reviewOrder(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    orderReview.action = 'MyAccount';
    orderReview.page = 'OrderReview';
    orderReview.message = messageCont.text;
    orderReview.customerId = preferences.getString('id');
    if (orderReview.message == null || orderReview.message?.trim() == '') {
      orderReview.message = ' - ';
    }
    RestAPI()
        .getData(url: ApiPath.orderReview, body: orderReview.toJson())
        .then((value) {
      getOrdertList(); // get order again
      Navigator.pop(context); // close loading

      normalDialog(context, 'รีวิวสำเร็จ', onPressed: () {
        Provider.of<FragmentProvider>(context, listen: false)
            .changeIndexpage(1);

        Navigator.popUntil(context, ModalRoute.withName('/fragment'));
      });
    });
  }

  String orderType(int index) {
    String _type = '';
    if (listMenuOrder![index].paymentMethod == 'cod')
      _type = 'เก็บเงินปลายทาง';
    else if (listMenuOrder![index].paymentMethod == 'omise_credit_card')
      _type = 'บัตรเครดิต';
    else if (listMenuOrder![index].paymentMethod == 'truemoney_wallet')
      _type = 'ทรูมันนี่วอลเล็ท';
    else if (listMenuOrder![index].paymentMethod == 'mobile_banking')
      _type = 'โมบายแบงค์กิ้ง';
    else if (listMenuOrder![index].paymentMethod == 'promptpay')
      _type = 'พร้อมเพย์';
    else
      _type = 'รับเอง';
    return _type;
  }

  void getOrderId(int index) {
    indexStsReview = index;
    orderReview.orderId = listMenuOrder![index].id.toString();
  }

  onChangeRiderRatting(double data) {
    orderReview.driverRating = data;
    notifyListeners();
  }

  onChangeRestRatting(double data) {
    orderReview.rating = data;
    notifyListeners();
  }

  clearRatingReview() {
    orderReview.driverRating = 0;
    orderReview.rating = 0;
    messageCont.text = '';
    notifyListeners();
  }

  bool checkValidateRating(BuildContext context) {
    bool _stsvai = false;

    if (orderReview.rating == 0 && orderReview.driverRating == 0) {
      _stsvai = false;
      normalDialog(context, 'กรุณากรอกข้อมูลความพึงพอใจ');
    } else if (orderReview.rating == 0) {
      _stsvai = false;
      normalDialog(context, 'กรุณากรอกข้อมูลความพึงพอใจของร้านค้า');
    } else if (orderReview.driverRating == 0) {
      _stsvai = false;
      normalDialog(context, 'กรุณากรอกข้อมูลความพึงพอใจของคนขับ');
    } else if ((orderReview.rating! > 0 && orderReview.rating! <= 3) &&
        messageCont.text.trim().isEmpty) {
      _stsvai = false;
      normalDialog(context, 'กรุณากรอกข้อมูลความเห็น');
    } else
      _stsvai = true;
    return _stsvai;
  }

  submitRating(BuildContext context) {
    if (checkValidateRating(context)) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) =>
              SpinKitPouringHourGlass(color: Colors.amber, size: 125));

      reviewOrder(context);
    }
  }
}

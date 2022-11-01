import 'dart:async';
import 'package:flutter/material.dart';
import 'package:/model/FromJSON/OrderDetailModel.dart';
import 'package:/services/request/RestAPI.dart';
import 'package:/services/route/ApiPath.dart';
import 'package:/utils/Constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailDeliveryProvider extends ChangeNotifier {
  DetailDeliveryProvider();

  String statusOrder = '';
  int orderid = 0;

  //Timer? timerDuration;
  Timer timerDuration = Timer.periodic(Duration(seconds: 5), (_) {});

  bool redpointbttsheet = true;
  bool driverSts = false;
  int sumPriceAllMenu = 0;
  int deliveryPrice = 0;
  double sumTotal = 0;
  List colorSuccess = [
    Color(0xFF40C057),
    Color(0xFFA19F9F),
    Color(0xFFA19F9F),
  ];

  String orderNumber = '';
  bool stsLoading = false;
  String page = '';

  OrderDetailModel? model;
  OrderDetail? orderDetail;
  CustomerDetails? customerDetails;
  List<Productdetail>? productdetail;
  DriverDetail? driverDetail;
  StoreDetail? storeDetail;
  CustDetail? custDetail;

  intitdata() {
    stsLoading = false;
    sumTotal = double.parse(deliveryPrice.toString()) +
        double.parse(sumPriceAllMenu.toString());
  }

  stopLoading() {
    orderid = 0;
    timerDuration.cancel();
    notifyListeners();
  }

  Future getDataByOrderList(int orderId, {String? page}) async {
    //  isStopped = false;
    this.page = page ?? 'order';

    // this.orderid = orderId;

    var preferences = await SharedPreferences.getInstance();

    var body = {
      "customer_id": preferences.getString('id'),
      "action": "MyAccount",
      "page": "OrderDetail",
      "orderId": orderId
    };

    await RestAPI()
        .getData(
      url: ApiPath.orderDetail,
      body: body,
    )
        .then(
      (value) {
        debugPrint('recursive check order $orderId');

        model = OrderDetailModel.fromJson(value);
        driverSts = model!.result!.driverDetail == null ? false : true;
        orderDetail = model!.result!.orderDetail;
        customerDetails = model!.result!.customerDetails;
        productdetail = model!.result!.productdetail;
        driverDetail = model!.result!.driverDetail?.first;
        custDetail = model!.result!.custDetail;
        storeDetail = model!.result!.storeDetail?.first ??
            StoreDetail(address: '', email: '', id: 0, name: '', phone: '0');
        orderNumber = orderDetail!.refNumber!;

        preferences.setString('orderName', orderNumber);

        statusOrder = orderDetail!.orderStatusText!;

        List<String> _date = Constants()
            .dateTimeTHFormat(
              dateTime: model!.result!.orderDetail!.orderDate!,
              formatDate: "yyyy-MM-ddTHH:mm:ss+07:00",
            )
            .split(' - ');

        orderDetail!.orderDate = _date.first;
        orderDetail!.orderTime = _date[1];

        if (orderDetail!.orderStatusText == 'ยกเลิก') {
          colorSuccess[0] = Colors.red;
          colorSuccess[1] = Colors.red;
          colorSuccess[2] = Colors.red;
        } else if (orderDetail!.orderStatusText == 'จัดส่งเรียบร้อย') {
          colorSuccess[0] = Color(0xFF40C057);
          colorSuccess[1] = Color(0xFF40C057);
          colorSuccess[2] = Color(0xFF40C057);
        } else if (orderDetail!.orderStatusText == 'ถึงร้านค้า' ||
            orderDetail!.percentToShop == 100) {
          colorSuccess[0] = Color(0xFF40C057);
          colorSuccess[1] = Color(0xFF40C057);
          colorSuccess[2] = Color(0xFFA19F9F);
        } else {
          colorSuccess[0] = Color(0xFF40C057);
          colorSuccess[1] = Color(0xFFA19F9F);
          colorSuccess[2] = Color(0xFFA19F9F);
        }

        var time = DateFormat('hh:mm')
            .parse(model!.result!.orderDetail!.deliveryTime!);
        var timeDelivery =
            DateFormat('HH:mm').format(time); // 31/12/2000, 22:00
        model!.result!.orderDetail!.deliveryTime = timeDelivery;

        stsLoading = true;

        // check order กรณีที่ web hook ไม่ทำงาน
        // if (orderDetail!.paymentStatus == 'NP' &&
        //     orderDetail!.status == 'Waiting' &&
        //     orderDetail!.paymentType != 'cod' &&
        //     this.orderid != orderId) {
        //   this.orderid = orderId;

        //   timerDuration = Timer.periodic(Duration(seconds: 5), (_) {
        //     if (orderDetail!.paymentStatus == 'NP' &&
        //         orderDetail!.status == 'Waiting' &&
        //         orderDetail!.paymentType != 'cod') {
        //       var bodyUpdate = {
        //         "action": "MyAccount",
        //         "page": "omiseOrderReview",
        //         "order_id": this.orderid,
        //         "customer_id": preferences.getString('id')
        //       };

        //       RestAPI()
        //           .getData(url: ApiPath.orderUpdate, body: bodyUpdate)
        //           .then((value) {
        //         model = OrderDetailModel.fromJson(value);
        //       });

        //       getDataByOrderList(this.orderid);
        //     }
        //   });
        // } else {
        // recursive เช็คจนกว่า order จะ success or cancel
        if (statusOrder != 'ยกเลิก' &&
            statusOrder != 'จัดส่งเรียบร้อย' &&
            this.orderid != orderId) {
          this.orderid = orderId;
          timerDuration = Timer.periodic(
            Duration(seconds: 5),
            (_) {
              if (statusOrder != 'ยกเลิก' && statusOrder != 'จัดส่งเรียบร้อย') {
                getDataByOrderList(this.orderid);
              }
            },
          );
        }
        // }

        notifyListeners();
      },
    );
  }

  onChangeStatusRedPoint() {
    // เอาไว้ ้hide ปุ่มสีแดง
    redpointbttsheet = false;
    notifyListeners();
  }
}

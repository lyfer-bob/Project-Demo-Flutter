class OrderListModel {
  String? status;
  Result? result;

  OrderListModel({this.status, this.result});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  List<OrderLists>? orderLists;

  Result({this.success, this.orderLists});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.orderLists = json["orderLists"] == null
        ? null
        : (json["orderLists"] as List)
            .map((e) => OrderLists.fromJson(e))
            .toList();
  }
}

class OrderLists {
  String? orderNumber;
  int? id;
  String? paymentMethod;
  double? orderGrandTotal;
  String? paymentStatus;
  String? status;
  String? sourceLatitude;
  String? sourceLongitude;
  String? destinationLatitude;
  String? destinationLongitude;
  String? splitPayment;
  String? orderType;
  String? walletAmount;
  bool? reviewStatus;
  int? rating;
  int? ratingDriver;
  String? orderStatus;
  String? driverStatus;
  String? storeStatus;
  String? orderStatusText;
  String? driverStatusText;
  String? storeStatusText;
  String? cancelType;
  String? cancelBy;
  String? cancelReason;
  String? cancelDate;
  dynamic orderDate;
  String? deliveryDate;
  int? driverId;
  dynamic driverName;
  dynamic driverNo;
  dynamic driverImg;
  int? restaurantId;
  String? restaurantName;
  String? restaurantLogo;

  OrderLists(
      {this.orderNumber,
      this.id,
      this.paymentMethod,
      this.orderGrandTotal,
      this.paymentStatus,
      this.status,
      this.sourceLatitude,
      this.sourceLongitude,
      this.destinationLatitude,
      this.destinationLongitude,
      this.splitPayment,
      this.orderType,
      this.walletAmount,
      this.reviewStatus,
      this.rating,
      this.ratingDriver,
      this.orderStatus,
      this.driverStatus,
      this.storeStatus,
      this.orderStatusText,
      this.driverStatusText,
      this.storeStatusText,
      this.cancelType,
      this.cancelBy,
      this.cancelReason,
      this.cancelDate,
      this.orderDate,
      this.deliveryDate,
      this.driverId,
      this.driverName,
      this.driverNo,
      this.driverImg,
      this.restaurantId,
      this.restaurantName,
      this.restaurantLogo});

  OrderLists.fromJson(Map<String, dynamic> json) {
    this.orderNumber = json["order_number"];
    this.id = json["id"];
    this.paymentMethod = json["payment_method"];
    this.orderGrandTotal = double.parse(json["order_grand_total"].toString());
    this.paymentStatus = json["payment_status"];
    this.status = json["status"];
    this.sourceLatitude = json["source_latitude"];
    this.sourceLongitude = json["source_longitude"];
    this.destinationLatitude = json["destination_latitude"];
    this.destinationLongitude = json["destination_longitude"];
    this.splitPayment = json["split_payment"];
    this.orderType = json["order_type"];
    // this.walletAmount = json["wallet_amount"];
    this.reviewStatus = json["review_status"];
    this.rating = json["rating"];
    this.ratingDriver = json["rating_driver"];
    this.orderStatus = json["order_status"];
    this.driverStatus = json["driver_status"];
    this.storeStatus = json["store_status"];
    this.orderStatusText = json["order_status_text"];
    this.driverStatusText = json["driver_status_text"];
    this.storeStatusText = json["store_status_text"];
    this.cancelType = json["cancel_type"];
    this.cancelBy = json["cancel_by"];
    this.cancelReason = json["cancel_reason"];
    this.cancelDate = json["cancel_date"];
    this.orderDate = json["order_date"];
    this.deliveryDate = json["delivery_date"];
    this.driverId = json["driver_id"];
    this.driverName = json["driver_name"];
    this.driverNo = json["driver_no"];
    this.driverImg = json["driver_img"];
    this.restaurantId = json["restaurant_id"];
    this.restaurantName = json["restaurant_name"];
    this.restaurantLogo = json["restaurant_logo"];
  }
}

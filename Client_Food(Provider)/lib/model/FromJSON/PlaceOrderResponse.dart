class PlaceOrderResponse {
  String? status;
  Result? result;

  PlaceOrderResponse({this.status, this.result});

  PlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  String? message;
  int? orderId;
  String? orderNumber;

  Result({this.success, this.message, this.orderId, this.orderNumber});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.message = json["message"];
    this.orderId = json["order_id"];
    this.orderNumber = json["order_number"];
  }
}

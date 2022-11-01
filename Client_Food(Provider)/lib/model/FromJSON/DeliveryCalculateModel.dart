class DeliveryCalculateModel {
  String? success;
  String? message;
  Result? result;

  DeliveryCalculateModel({this.success, this.message, this.result});

  DeliveryCalculateModel.fromJson(Map<String, dynamic> json) {
    this.success = json["success"].toString();
    this.message = json["message"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? refNo;
  String? customerRefId;
  String? restaurantRefId;
  int? deliveryCost;
  int? riderIncome;

  Result(
      {this.refNo,
      this.customerRefId,
      this.restaurantRefId,
      this.deliveryCost,
      this.riderIncome});

  Result.fromJson(Map<String, dynamic> json) {
    this.refNo = json["ref_no"];
    this.customerRefId = json["customer_ref_id"];
    this.restaurantRefId = json["restaurant_ref_id"];
    this.deliveryCost = json["delivery_cost"];
    this.riderIncome = json["rider_income"];
  }
}

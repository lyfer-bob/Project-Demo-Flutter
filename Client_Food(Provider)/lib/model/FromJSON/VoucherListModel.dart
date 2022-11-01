class VoucherListModel {
  String? status;
  Result? result;

  VoucherListModel({this.status, this.result});

  VoucherListModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<VoucherList>? voucherList;
  int? success;
  String? message;

  Result({this.voucherList, this.success, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    this.voucherList = json["voucherList"] == null
        ? null
        : (json["voucherList"] as List)
            .map((e) => VoucherList.fromJson(e))
            .toList();
    this.success = json["success"];
    this.message = json["message"];
  }
}

class VoucherList {
  int? id;
  String? voucherCode;
  String? typeOffer;
  String? offerMode;
  String? offerText;
  String? offerDesc;
  String? freeDelivery;
  int? offerValue;
  int? eligiblePoints;
  double? maximumOrder;
  int? minimumOrder;
  String? voucherFrom;
  String? voucherTo;
  int? maxQuota;
  dynamic useQuota;

  VoucherList(
      {this.id,
      this.voucherCode,
      this.typeOffer,
      this.offerMode,
      this.offerDesc,
      this.offerText,
      this.freeDelivery,
      this.offerValue,
      this.eligiblePoints,
      this.maximumOrder,
      this.minimumOrder,
      this.voucherFrom,
      this.voucherTo,
      this.maxQuota,
      this.useQuota});

  VoucherList.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.voucherCode = json["voucher_code"];
    this.typeOffer = json["type_offer"];
    this.offerMode = json["offer_mode"];
    this.freeDelivery = json["free_delivery"];
    this.offerValue = json["offer_value"];
    this.eligiblePoints = json["eligible_points"];
    this.maximumOrder = double.parse(json["maximum_order"].toString());
    this.minimumOrder = json["minimum_order"];
    this.voucherFrom = json["voucher_from"];
    this.voucherTo = json["voucher_to"];
    this.maxQuota = json["max_quota"];
    this.useQuota = json["use_quota"];
  }
}

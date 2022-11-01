class RewardHistory {
  String? status;
  Result? result;

  RewardHistory({this.status, this.result});

  RewardHistory.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    if (this.result != null) data["result"] = this.result!.toJson();
    return data;
  }
}

class Result {
  String? totalPoints;
  List<CustomerPoints>? customerPoints;
  int? success;

  Result({this.totalPoints, this.customerPoints, this.success});

  Result.fromJson(Map<String, dynamic> json) {
    this.totalPoints = json["totalPoints"];
    this.customerPoints = json["customerPoints"] == null
        ? null
        : (json["customerPoints"] as List)
            .map((e) => CustomerPoints.fromJson(e))
            .toList();
    this.success = json["success"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalPoints"] = this.totalPoints;
    if (this.customerPoints != null)
      data["customerPoints"] =
          this.customerPoints!.map((e) => e.toJson()).toList();
    data["success"] = this.success;
    return data;
  }
}

class CustomerPoints {
  int? id;
  int? orderId;
  String? restaurantName;
  int? customerId;
  double? total;
  int? points;
  String? type;
  String? status;
  String? created;
  String? modified;
  Order? order;

  CustomerPoints(
      {this.id,
      this.orderId,
      this.restaurantName,
      this.customerId,
      this.total,
      this.points,
      this.type,
      this.status,
      this.created,
      this.modified,
      this.order});

  CustomerPoints.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.orderId = json["order_id"];
    this.restaurantName = json["restaurant_name"];
    this.customerId = json["customer_id"];
    this.total = double.parse(json["total"].toString());
    this.points = json["points"];
    this.type = json["type"];
    this.status = json["status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.order = json["order"] == null ? null : Order.fromJson(json["order"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["order_id"] = this.orderId;
    data["restaurant_name"] = this.restaurantName;
    data["customer_id"] = this.customerId;
    data["total"] = this.total;
    data["points"] = this.points;
    data["type"] = this.type;
    data["status"] = this.status;
    data["created"] = this.created;
    data["modified"] = this.modified;
    if (this.order != null) data["order"] = this.order!.toJson();
    return data;
  }
}

class Order {
  String? orderNumber;
  double? rewardOffer;

  Order({this.orderNumber, this.rewardOffer});

  Order.fromJson(Map<String, dynamic> json) {
    this.orderNumber = json["order_number"];
    this.rewardOffer = double.parse(json["reward_offer"].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["order_number"] = this.orderNumber;
    data["reward_offer"] = this.rewardOffer;
    return data;
  }
}

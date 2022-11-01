class OrderUpdateModel {
  String? action;
  String? page;
  String? orderId;
  String? type;
  int? customerId;

  OrderUpdateModel(
      {this.action, this.page, this.orderId, this.type, this.customerId});

  OrderUpdateModel.fromJson(Map<String, dynamic> json) {
    this.action = json["action"];
    this.page = json["page"];
    this.orderId = json["order_id"];
    this.type = json["type"];
    this.customerId = json["customer_id"];
  }
}

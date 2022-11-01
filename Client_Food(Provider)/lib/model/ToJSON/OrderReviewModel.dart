class OrderReviewModel {
  String? customerId;
  String? action;
  String? page;
  String? orderId = '';
  double? rating;
  String? message = '';
  double? driverRating;

  OrderReviewModel(
      {this.customerId,
      this.action,
      this.page,
      this.orderId,
      required this.rating,
      this.message,
      required this.driverRating});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["customer_id"] = this.customerId.toString();
    data["action"] = this.action;
    data["page"] = this.page;
    data["order_id"] = this.orderId.toString();
    data["rating"] = this.rating.toString();
    data["message"] = this.message;
    data["driver_rating"] = this.driverRating.toString();
    return data;
  }
}

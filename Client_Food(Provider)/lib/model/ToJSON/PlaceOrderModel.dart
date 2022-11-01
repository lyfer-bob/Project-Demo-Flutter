class PlaceOrderModel {
  String? appVersion;
  String? addressTitle;
  String? orderDevice;
  String? refNo;
  int? customerType;
  String? voucherPercentage;
  String? voucherCode;
  String? action;
  double? rewardPercentage;
  double? ordertotalprice;
  int? customerId;
  int? voucherAmount;
  String? taxPercentage;
  String? deliveryCharge;
  String? driverIncome;
  String? deliveryCost;
  String? paymentName;
  String? orderPoint;
  String? deliveryId;
  String? paymentMethod;
  String? resid;
  String? rewardPoint;
  String? orderType;
  String? page;
  String? deliveryTime;
  String? transactionId;
  String? paidFull;
  String? tipamount;
  String? orderDescription;
  String? riderDescription;
  String? deliveryDate;
  String? taxAmount;
  String? offerPercentage;
  String? offerAmount;
  String? assoonas;
  String? customerPhone;
  String? orderSubTotal;
  String? deliveryDistance;
  String? timeMap;
  String? paymentId;
  String? omiseCreditCardChoose;
  String? omiseChargeId;
  String? offerId;
  List<Cartdetails>? cartdetails;

  PlaceOrderModel(
      {this.appVersion,
      this.addressTitle,
      this.orderDevice,
      this.refNo,
      this.customerType,
      this.voucherPercentage,
      this.voucherCode,
      this.action,
      this.rewardPercentage,
      this.ordertotalprice,
      this.customerId,
      this.voucherAmount,
      this.taxPercentage,
      this.deliveryCharge,
      this.driverIncome,
      this.deliveryCost,
      this.paymentName,
      this.orderPoint,
      this.deliveryId,
      this.paymentMethod,
      this.resid,
      this.rewardPoint,
      this.orderType,
      this.page,
      this.deliveryTime,
      this.transactionId,
      this.paidFull,
      this.tipamount,
      this.orderDescription,
      this.riderDescription,
      this.deliveryDate,
      this.taxAmount,
      this.offerPercentage,
      this.offerAmount,
      this.assoonas,
      this.customerPhone,
      this.orderSubTotal,
      this.deliveryDistance,
      this.timeMap,
      this.paymentId,
      this.cartdetails,
      this.omiseChargeId,
      this.offerId,
      this.omiseCreditCardChoose});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["app_version"] = this.appVersion;
    data["address_title"] = this.addressTitle;
    data["order_device"] = this.orderDevice;
    data["ref_no"] = this.refNo;
    data["customer_type"] = this.customerType;
    data["voucher_percentage"] = this.voucherPercentage;
    data["voucher_code"] = this.voucherCode;
    data["action"] = this.action;
    data["rewardPercentage"] = this.rewardPercentage;
    data["ordertotalprice"] = this.ordertotalprice;
    data["customer_id"] = this.customerId;
    data["voucher_amount"] = this.voucherAmount;
    data["tax_percentage"] = this.taxPercentage;
    data["delivery_charge"] = this.deliveryCharge;
    data["driver_income"] = this.driverIncome;
    data["delivery_cost"] = this.deliveryCost;
    data["payment_name"] = this.paymentName;
    data["order_point"] = this.orderPoint;
    data["delivery_id"] = this.deliveryId;
    data["payment_method"] = this.paymentMethod;
    data["resid"] = this.resid;
    data["rewardPoint"] = this.rewardPoint;
    data["order_type"] = this.orderType;
    data["page"] = this.page;
    data["delivery_time"] = this.deliveryTime;
    data["transaction_id"] = this.transactionId;
    data["paidFull"] = this.paidFull;
    data["tipamount"] = this.tipamount;
    data["order_description"] = this.orderDescription;
    data["rider_description"] = this.riderDescription;
    data["delivery_date"] = this.deliveryDate;
    data["tax_amount"] = this.taxAmount;
    data["offer_percentage"] = this.offerPercentage;
    data["offer_amount"] = this.offerAmount;
    data["assoonas"] = this.assoonas;
    data["customer_phone"] = this.customerPhone;
    data["order_sub_total"] = this.orderSubTotal;
    data["time_map"] = this.timeMap;
    data["delivery_distance"] = this.deliveryDistance;
    data["payment_id"] = this.paymentId;
    data["omise_credit_card_choose"] = this.omiseCreditCardChoose;
    data["offer_id"] = this.offerId;
    data["omise_charge_id"] = this.omiseChargeId;

    if (this.cartdetails != null)
      data["cartdetails"] = this.cartdetails!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Cartdetails {
  String? menuId;
  String? resId;
  String? menuName;
  String? menuType;
  String? menuSize;
  String? menuPrice;
  String? addonName;
  String? addonPrice;
  String? quantity;
  String? total;
  String? instruction;

  Cartdetails(
      {this.menuId,
      this.resId,
      this.menuName,
      this.menuType,
      this.menuSize,
      this.menuPrice,
      this.addonName,
      this.addonPrice,
      this.quantity,
      this.total,
      this.instruction});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["menu_id"] = this.menuId;
    data["res_id"] = this.resId;
    data["menu_name"] = this.menuName;
    data["menu_type"] = this.menuType;
    data["menu_size"] = this.menuSize;
    data["Menu_price"] = this.menuPrice;
    data["Addon_name"] = this.addonName;
    data["Addon_price"] = this.addonPrice;
    data["quantity"] = this.quantity;
    data["Total"] = this.total;
    data["instruction"] = this.instruction;
    return data;
  }
}

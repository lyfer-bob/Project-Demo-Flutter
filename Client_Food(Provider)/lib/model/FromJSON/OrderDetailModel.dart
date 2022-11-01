class OrderDetailModel {
  String? status;
  Result? result;

  OrderDetailModel({this.status, this.result});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? success;
  OrderDetail? orderDetail;

  String? firstName;
  String? lastName;
  String? email;
  String? customerPhone;
  CustomerDetails? customerDetails;
  List<Productdetail>? productdetail;
  List<DriverDetail>? driverDetail;
  List<StoreDetail>? storeDetail;
  CustDetail? custDetail;

  Result(
      {this.success,
      this.orderDetail,
      this.firstName,
      this.lastName,
      this.email,
      this.customerPhone,
      this.customerDetails,
      this.productdetail,
      this.driverDetail,
      this.storeDetail,
      this.custDetail});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"].toString();
    this.orderDetail = json["OrderDetail"] == null
        ? null
        : OrderDetail.fromJson(json["OrderDetail"]);

    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.email = json["email"];
    this.customerPhone = json["customerPhone"];
    this.customerDetails = json["customerDetails"] == null
        ? null
        : CustomerDetails.fromJson(json["customerDetails"]);
    this.custDetail = json["custDetail"] == null
        ? null
        : CustDetail.fromJson(json["custDetail"]);

    this.productdetail = json["productdetail"] == null
        ? null
        : (json["productdetail"] as List)
            .map((e) => Productdetail.fromJson(e))
            .toList();
    this.driverDetail = json["driverDetail"] == null
        ? null
        : (json["driverDetail"] as List)
            .map((e) => DriverDetail.fromJson(e))
            .toList();
    this.storeDetail = json["storeDetail"] == null
        ? null
        : (json["storeDetail"] as List)
            .map((e) => StoreDetail.fromJson(e))
            .toList();
  }
}

class StoreDetail {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  StoreDetail({this.id, this.name, this.email, this.phone, this.address});

  StoreDetail.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.phone = json["phone"];
    this.address = json["address"];
  }
}

class CustDetail {
  String? name;
  String? email;
  String? address;

  CustDetail({this.name, this.email, this.address});

  CustDetail.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.address = json["address"];
    this.email = json["email"];
  }
}

class DriverDetail {
  int? id;

  String? driverName;
  String? driverPhone;
  String? vehicleName;
  double? scoreReview;
  String? urlImg;
  String? driverCode;

  DriverDetail(
      {this.id,
      this.driverName,
      this.driverPhone,
      this.vehicleName,
      this.scoreReview,
      this.urlImg,
      this.driverCode});

  DriverDetail.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.driverName = json["driver_name"];
    this.driverPhone = json["driver_phone"];
    this.vehicleName = json["vehicle_name"];
    this.scoreReview = double.parse(
        json["score_review"] == null ? '0' : json["score_review"].toString());
    this.urlImg = json["url_img"];
    this.driverCode = json["driver_code"];
  }
}

class Productdetail {
  String? productname;
  int? quantity;
  int? total;
  String? price;
  String? productDescrption;
  String? subaddonsName;

  Productdetail(
      {this.productname,
      this.quantity,
      this.total,
      this.price,
      this.productDescrption,
      this.subaddonsName});

  Productdetail.fromJson(Map<String, dynamic> json) {
    this.productname = json["productname"];
    this.quantity = json["quantity"];
    this.total = json["total"];
    this.price = (int.parse(json["total"].toString()) /
            int.parse(json["quantity"].toString()))
        .toString();
    this.productDescrption = json["product_descrption"];
    this.subaddonsName = json["subaddons_name"];
  }
}

class CustomerDetails {
  int? id;
  int? roleId;
  String? username;
  String? password;
  String? permissions;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? userType;
  String? referralCode;
  String? referredBy;
  String? rewardExpiryDate;
  String? walletAmount;
  String? image;
  String? newsletter;
  String? signupFrom;
  String? signupDevice;
  String? deviceType;
  String? deviceId;
  dynamic rpayToken;
  String? status;
  String? deletedStatus;
  String? created;
  String? modified;

  CustomerDetails(
      {this.id,
      this.roleId,
      this.username,
      this.password,
      this.permissions,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.userType,
      this.referralCode,
      this.referredBy,
      this.rewardExpiryDate,
      this.walletAmount,
      this.image,
      this.newsletter,
      this.signupFrom,
      this.signupDevice,
      this.deviceType,
      this.deviceId,
      this.rpayToken,
      this.status,
      this.deletedStatus,
      this.created,
      this.modified});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.roleId = json["role_id"];
    this.username = json["username"];
    this.password = json["password"];
    this.permissions = json["permissions"];
    this.firstName = json["first_name"];
    this.lastName = json["last_name"];
    this.phoneNumber = json["phone_number"];
    this.address = json["address"];
    this.userType = json["user_type"];
    this.referralCode = json["referral_code"];
    this.referredBy = json["referred_by"];
    this.rewardExpiryDate = json["reward_expiry_date"];
    this.walletAmount = json["wallet_amount"].toString();
    this.image = json["image"];
    this.newsletter = json["newsletter"];
    this.signupFrom = json["signup_from"];
    this.signupDevice = json["signup_device"];
    this.deviceType = json["device_type"];
    this.deviceId = json["device_id"];
    this.rpayToken = json["rpay_token"];
    this.status = json["status"];
    this.deletedStatus = json["deleted_status"];
    this.created = json["created"];
    this.modified = json["modified"];
  }
}

class OrderDetail {
  String? status;
  int? tax;
  int? subTot;
  int? delivery;
  double? grandTot;
  String? name;
  int? id;
  String? assoonas;
  String? refNumber;
  String? paymentStatus;
  String? orderType;
  String? phone;
  String? mail;
  String? flatNo;
  String? address;
  String? fulladdress;
  String? orderdescrption;
  String? deliveryDate;
  String? deliveryTime;
  String? orderDate;
  String? orderTime;
  String? paymentType;
  double? offer;
  double? offerPercentage;
  double? taxPercentage;
  double? voucherPercentage;
  double? voucherAmount;
  String? voucherMode;
  String? splitPayment;
  String? walletAmount;
  int? tipAmount;
  double? rewardOffer;
  double? rewardOfferPercentage;
  String? doorNo;
  String? orderPoint;
  String? driverRemark;
  String? imgOrderStatus;
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
  String? driverLatitudeStart;
  String? driverLongitudeStart;
  String? driverLatitudeEnd;
  String? driverLongitudeEnd;
  String? assignStartTime;
  String? driverTimeStart;
  String? driverTimeEnd;
  int? driverIncome;
  int? deliveryCost;
  String? deliveryDistanceCal;
  String? deliveryTimesCal;
  int? percentToShop;
  int? percentToClient;
  int? driverAssignType;
  int? timeRemain;
  int? customerId;

  OrderDetail({
    this.status,
    this.tax,
    this.subTot,
    this.delivery,
    this.grandTot,
    this.name,
    this.id,
    this.assoonas,
    this.refNumber,
    this.paymentStatus,
    this.orderType,
    this.phone,
    this.mail,
    this.flatNo,
    this.address,
    this.fulladdress,
    this.orderdescrption,
    this.deliveryDate,
    this.deliveryTime,
    this.orderDate,
    this.orderTime,
    this.paymentType,
    this.offer,
    this.offerPercentage,
    this.taxPercentage,
    this.voucherPercentage,
    this.voucherAmount,
    this.voucherMode,
    this.splitPayment,
    this.walletAmount,
    this.tipAmount,
    this.rewardOffer,
    this.rewardOfferPercentage,
    this.doorNo,
    this.orderPoint,
    this.driverRemark,
    this.imgOrderStatus,
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
    this.driverLatitudeStart,
    this.driverLongitudeStart,
    this.driverLatitudeEnd,
    this.driverLongitudeEnd,
    this.assignStartTime,
    this.driverTimeStart,
    this.driverTimeEnd,
    this.driverIncome,
    this.deliveryCost,
    this.deliveryDistanceCal,
    this.deliveryTimesCal,
    this.percentToShop,
    this.percentToClient,
    this.driverAssignType,
    this.timeRemain,
    this.customerId,
  });

  OrderDetail.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.tax = json["tax"];
    this.subTot = json["sub_tot"];
    this.delivery = json["delivery"];
    this.grandTot = double.parse(
        json["grand_tot"] == null ? '0' : json["grand_tot"].toString());
    this.name = json["name"];
    this.id = json["id"];
    this.assoonas = json["assoonas"];
    this.refNumber = json["ref_number"];
    this.paymentStatus = json["paymentStatus"];
    this.orderType = json["orderType"];
    this.phone = json["phone"];
    this.mail = json["mail"];
    this.flatNo = json["flat_no"];
    this.address = json["address"];
    this.fulladdress = json["fulladdress"];
    this.orderdescrption = json["orderdescrption"];
    this.deliveryDate = json["DeliveryDate"];
    this.deliveryTime = json["DeliveryTime"];
    this.orderDate = json["order_date"];
    this.paymentType = json["payment_type"];
    this.offer = double.parse(json["offer"].toString());
    this.offerPercentage = double.parse(json["offerPercentage"].toString());
    this.taxPercentage = double.parse(json["taxPercentage"].toString());
    this.voucherPercentage = double.parse(json["voucherPercentage"].toString());
    this.voucherAmount = double.parse(
        json["voucherAmount"] == null ? '0' : json["voucherAmount"].toString());
    this.voucherMode = json["voucherMode"];
    this.splitPayment = json["splitPayment"];
    this.walletAmount = json["walletAmount"];
    this.tipAmount = json["tipAmount"];
    this.rewardOffer = double.parse(
        json["rewardOffer"] == null ? '0' : json["rewardOffer"].toString());
    this.rewardOfferPercentage = double.parse(
        json["rewardOfferPercentage"] == null
            ? '0'
            : json["rewardOfferPercentage"].toString());
    this.doorNo = json["doorNo"];
    this.orderPoint = json["order_point"].toString();
    this.driverRemark = json["driver_remark"];
    this.imgOrderStatus = json["img_order_status"];
    this.orderStatus = json["order_status"];
    this.driverStatus = json["driver_status"];
    this.storeStatus = json["store_status"];
    this.orderStatusText = json["order_status_text"];
    this.driverStatusText = json["driver_status_text"];
    this.storeStatusText = json["store_status_text"];
    this.cancelType = json["cancel_type"].toString();
    this.cancelBy = json["cancel_by"];
    this.cancelReason = json["cancel_reason"];
    this.cancelDate = json["cancel_date"];
    this.driverLatitudeStart = json["driver_latitude_start"];
    this.driverLongitudeStart = json["driver_longitude_start"];
    this.driverLatitudeEnd = json["driver_latitude_end"];
    this.driverLongitudeEnd = json["driver_longitude_end"];
    this.assignStartTime = json["assign_start_time"];
    this.driverTimeStart = json["driver_time_start"];
    this.driverTimeEnd = json["driver_time_end"];
    this.driverIncome = json["driver_income"];
    this.deliveryCost = json["delivery_cost"];
    this.deliveryDistanceCal = json["delivery_distance_cal"].toString();
    this.deliveryTimesCal = json["delivery_times_cal"].toString();
    this.percentToShop = json["percent_to_shop"];
    this.percentToClient = json["percent_to_client"];
    this.driverAssignType = json["driver_assign_type"];
    this.timeRemain = json["time_remain"];
    this.customerId = json["customer_id"];
  }
}

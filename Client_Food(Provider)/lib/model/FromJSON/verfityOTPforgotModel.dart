class VerfityOTPForgotModel {
  VerfityOTPForgotModel({
    this.status,
    this.result,
  });

  VerfityOTPForgotModel.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? status;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }
}

class Result {
  Result({
    this.success,
    this.message,
    this.pinId,
    this.clientInfo,
  });

  Result.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    pinId = json['pin_id'];
    clientInfo = json['client_info'] != null
        ? ClientInfo.fromJson(json['client_info'])
        : null;
  }
  int? success;
  String? message;
  String? pinId;
  ClientInfo? clientInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['pin_id'] = pinId;
    if (clientInfo != null) {
      map['client_info'] = clientInfo?.toJson();
    }
    return map;
  }
}

class ClientInfo {
  ClientInfo({
    this.firstUser,
    this.success,
    this.customerId,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.referralCode,
    this.customerPhone,
    this.otp,
  });

  ClientInfo.fromJson(dynamic json) {
    firstUser = json['first_user'];
    success = json['success'];
    customerId = json['customerId'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    referralCode = json['referral_code'];
    customerPhone = json['customerPhone'];
    otp = json['otp'];
  }
  String? firstUser;
  int? success;
  int? customerId;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? referralCode;
  String? customerPhone;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_user'] = firstUser;
    map['success'] = success;
    map['customerId'] = customerId;
    map['name'] = name;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['referral_code'] = referralCode;
    map['customerPhone'] = customerPhone;
    map['otp'] = otp;
    return map;
  }
}

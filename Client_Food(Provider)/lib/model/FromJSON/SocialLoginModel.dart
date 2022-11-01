/// status : "OK"
/// result : {"first_user":"No","success":1,"message":"เข้าสู่ระบบสำเร็จ","customerId":34174,"name":"Surachate Talung","firstName":"Surachate","lastName":"Talung","email":"ai.wisdomstudio@gmail.com","customerPhone":"065938894","wallet_amount":"0.0","custDeviceId":1705,"sex":"NA","birthday":"19700101"}

class SocialLoginModel {
  SocialLoginModel({
    this.status,
    this.result,
  });

  SocialLoginModel.fromJson(dynamic json) {
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

/// first_user : "No"
/// success : 1
/// message : "เข้าสู่ระบบสำเร็จ"
/// customerId : 34174
/// name : "Surachate Talung"
/// firstName : "Surachate"
/// lastName : "Talung"
/// email : "ai.wisdomstudio@gmail.com"
/// customerPhone : "065938894"
/// wallet_amount : "0.0"
/// custDeviceId : 1705
/// sex : "NA"
/// birthday : "19700101"

class Result {
  Result({
    this.firstUser,
    this.success,
    this.message,
    this.customerId,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.customerPhone,
    this.walletAmount,
    this.custDeviceId,
    this.sex,
    this.birthday,
  });

  Result.fromJson(dynamic json) {
    firstUser = json['first_user'].toString();
    success = json['success'].toString(); //
    message = json['message'].toString();
    customerId = json['customerId'].toString(); //
    name = json['name'].toString();
    firstName = json['firstName'].toString();
    lastName = json['lastName'].toString();
    email = json['email'].toString();
    customerPhone = json['customerPhone'].toString() != 'null'
        ? json['customerPhone'].toString()
        : '';
    walletAmount = json['wallet_amount'] != null ||
            json['wallet_amount'].toString() != 'null' ||
            json['wallet_amount'] != ''
        ? json['wallet_amount'].toString()
        : '0.0';
    custDeviceId = json['custDeviceId'].toString();
    sex = json['sex'] != null || json['sex'].toString() != 'null'
        ? json['sex'].toString()
        : 'NA';
    birthday = json['birthday'] != null || json['birthday'].toString() != 'null'
        ? json['birthday'].toString()
        : '';
  }

  String? firstUser;
  String? success;
  String? message;
  String? customerId;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? customerPhone;
  String? walletAmount;
  String? custDeviceId;
  String? sex;
  String? birthday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_user'] = firstUser;
    map['success'] = success;
    map['message'] = message;
    map['customerId'] = customerId;
    map['name'] = name;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['customerPhone'] = customerPhone;
    map['wallet_amount'] = walletAmount;
    map['custDeviceId'] = custDeviceId;
    map['sex'] = sex;
    map['birthday'] = birthday;
    return map;
  }
}

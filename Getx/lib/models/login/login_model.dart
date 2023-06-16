// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  String? message;
  String? tenant;
  String? orgUnit;
  int? userMainId;
  int? tenantMainId;
  int? orgUnitMainId;
  String? phoneNumber;
  String? userName;
  String? firstName;
  String? lastName;
  String? profilePicuture;
  String? emailAddress;
  String? accessToken;
  int? expireInSeconds;
  String? expireDate;
  String? refreshToken;
  int? refreshTokenExpireInSeconds;
  String? refreshTokenExpireDate;

  LoginModel({
    this.status,
    this.message,
    this.tenant,
    this.orgUnit,
    this.userMainId,
    this.tenantMainId,
    this.orgUnitMainId,
    this.phoneNumber,
    this.userName,
    this.firstName,
    this.lastName,
    this.profilePicuture,
    this.emailAddress,
    this.accessToken,
    this.expireInSeconds,
    this.expireDate,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
    this.refreshTokenExpireDate,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        tenant: json["tenant"],
        orgUnit: json["orgUnit"],
        userMainId: json["userMainId"],
        tenantMainId: json["tenantMainId"],
        orgUnitMainId: json["orgUnitMainId"],
        phoneNumber: json["phoneNumber"],
        userName: json["userName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profilePicuture: json["profilePicuture"],
        emailAddress: json["emailAddress"],
        accessToken: json["accessToken"],
        expireInSeconds: json["expireInSeconds"],
        expireDate: json["expireDate"],
        refreshToken: json["refreshToken"],
        refreshTokenExpireInSeconds: json["refreshTokenExpireInSeconds"],
        refreshTokenExpireDate: json["refreshTokenExpireDate"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "tenant": tenant,
        "orgUnit": orgUnit,
        "userMainId": userMainId,
        "tenantMainId": tenantMainId,
        "orgUnitMainId": orgUnitMainId,
        "phoneNumber": phoneNumber,
        "userName": userName,
        "firstName": firstName,
        "lastName": lastName,
        "profilePicuture": profilePicuture,
        "emailAddress": emailAddress,
        "accessToken": accessToken,
        "expireInSeconds": expireInSeconds,
        "expireDate": expireDate,
        "refreshToken": refreshToken,
        "refreshTokenExpireInSeconds": refreshTokenExpireInSeconds,
        "refreshTokenExpireDate": refreshTokenExpireDate,
      };
}

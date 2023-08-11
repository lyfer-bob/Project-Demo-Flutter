// To parse this JSON data, do
//
//     final requestOtpModel = requestOtpModelFromJson(jsonString);

import 'dart:convert';

class RequestOtpModel {
  String? refCode;
  String? otp;

  RequestOtpModel({
    this.refCode,
    this.otp,
  });

  factory RequestOtpModel.fromRawJson(String str) =>
      RequestOtpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestOtpModel.fromJson(Map<String, dynamic> json) =>
      RequestOtpModel(
        refCode: json["ref_code"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "ref_code": refCode,
        "otp": otp,
      };
}

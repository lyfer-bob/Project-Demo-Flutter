// To parse this JSON data, do
//
//     final registerReqeust = registerReqeustFromJson(jsonString);

import 'dart:convert';

class Register {
  String? firstName;
  String? lastName;
  String? mobileTel;
  String? refCode;
  String? otp;

  Register({
    this.firstName,
    this.lastName,
    this.mobileTel,
    this.refCode,
    this.otp,
  });

  factory Register.fromRawJson(String str) =>
      Register.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobileTel: json["mobile_tel"],
        refCode: json["ref_code"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile_tel": mobileTel,
        "ref_code": refCode,
        "otp": otp,
      };
}

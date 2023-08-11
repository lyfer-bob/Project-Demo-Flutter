// To parse this JSON data, do
//
//     final requestOtp = requestOtpFromJson(jsonString);

import 'dart:convert';

class RequestOtp {
  String? firstName;
  String? lastName;
  String? mobileTel;

  RequestOtp({
    this.firstName,
    this.lastName,
    this.mobileTel,
  });

  factory RequestOtp.fromRawJson(String str) =>
      RequestOtp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequestOtp.fromJson(Map<String, dynamic> json) => RequestOtp(
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobileTel: json["mobile_tel"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "mobile_tel": mobileTel,
      };
}

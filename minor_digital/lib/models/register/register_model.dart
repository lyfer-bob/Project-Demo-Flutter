// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

class RegisterModel {
  bool? isValid;

  RegisterModel({
    this.isValid,
  });

  factory RegisterModel.fromRawJson(String str) =>
      RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        isValid: json["is_valid"],
      );

  Map<String, dynamic> toJson() => {
        "is_valid": isValid,
      };
}

// To parse this JSON data, do
//
//     final tokenGenerateModel = tokenGenerateModelFromJson(jsonString);

import 'dart:convert';

class TokenGenerate {
  String? refId;
  int? expiredInDay;

  TokenGenerate({
    this.refId,
    this.expiredInDay,
  });

  factory TokenGenerate.fromRawJson(String str) =>
      TokenGenerate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TokenGenerate.fromJson(Map<String, dynamic> json) => TokenGenerate(
        refId: json["ref_id"],
        expiredInDay: json["expired_in_day"],
      );

  Map<String, dynamic> toJson() => {
        "ref_id": refId,
        "expired_in_day": expiredInDay,
      };
}

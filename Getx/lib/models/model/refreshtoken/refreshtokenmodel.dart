import 'package:json_annotation/json_annotation.dart';

part 'refreshtokenmodel.g.dart';

@JsonSerializable()
class Refreshtokenmodel {
  Refreshtokenmodel();

  late String status;
  late String message;
  late String accessToken;
  late num expireInSeconds;
  late String expireDate;
  late String refreshToken;
  late num refreshTokenExpireInSeconds;
  late String refreshTokenExpireDate;
  
  factory Refreshtokenmodel.fromJson(Map<String,dynamic> json) => _$RefreshtokenmodelFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshtokenmodelToJson(this);
}

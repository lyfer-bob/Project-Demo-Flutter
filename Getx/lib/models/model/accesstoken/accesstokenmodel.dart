import 'package:json_annotation/json_annotation.dart';

part 'accesstokenmodel.g.dart';

@JsonSerializable()
class Accesstokenmodel {
  Accesstokenmodel();

  late String status;
  late String message;
  late String accessToken;
  late num expireInSeconds;
  late String expireDate;
  
  factory Accesstokenmodel.fromJson(Map<String,dynamic> json) => _$AccesstokenmodelFromJson(json);
  Map<String, dynamic> toJson() => _$AccesstokenmodelToJson(this);
}

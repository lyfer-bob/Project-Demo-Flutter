import 'package:json_annotation/json_annotation.dart';

part 'logoutmodel.g.dart';

@JsonSerializable()
class Logoutmodel {
  Logoutmodel();

  late String status;
  late String message;
  
  factory Logoutmodel.fromJson(Map<String,dynamic> json) => _$LogoutmodelFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutmodelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  Login();

  late String userNameOrEmailAddress;
  late String password;
  late String deviceId;
  late String deviceName;
  late String deviceOS;
  
  factory Login.fromJson(Map<String,dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

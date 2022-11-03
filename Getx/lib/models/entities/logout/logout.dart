import 'package:json_annotation/json_annotation.dart';

part 'logout.g.dart';

@JsonSerializable()
class Logout {
  Logout();

  late num userId;
  late String userNameOrEmailAddress;
  late String deviceId;
  
  factory Logout.fromJson(Map<String,dynamic> json) => _$LogoutFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutToJson(this);
}

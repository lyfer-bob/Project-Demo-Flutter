import 'package:json_annotation/json_annotation.dart';
import "datatest.dart";
part 'logout.g.dart';

@JsonSerializable()
class Logout {
  Logout();

  late String status;
  late String message;
  late num testInt;
  late bool testModel;
  late Datatest testojb;
  
  factory Logout.fromJson(Map<String,dynamic> json) => _$LogoutFromJson(json);
  Map<String, dynamic> toJson() => _$LogoutToJson(this);
}

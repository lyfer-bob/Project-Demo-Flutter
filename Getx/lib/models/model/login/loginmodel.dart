import 'package:json_annotation/json_annotation.dart';
import "nodetenant.dart";
import "nodeorgunit.dart";
part 'loginmodel.g.dart';

@JsonSerializable()
class Loginmodel {
  Loginmodel();

  late String status;
  late String message;
  late List<Nodetenant> tenant;
  late List<Nodeorgunit> orgUnit;
  late num userMainId;
  late num tenantMainId;
  late num orgUnitMainId;
  late String phoneNumber;
  late String userName;
  late String firstName;
  late String lastName;
  late String profilePicuture;
  late String emailAddress;
  late String accessToken;
  late num expireInSeconds;
  late String expireDate;
  late String refreshToken;
  late num refreshTokenExpireInSeconds;
  late String refreshTokenExpireDate;

  factory Loginmodel.fromJson(Map<String, dynamic> json) =>
      _$LoginmodelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginmodelToJson(this);
}

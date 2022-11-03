// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginmodel _$LoginmodelFromJson(Map<String, dynamic> json) => Loginmodel()
  ..status = json['status'] as String
  ..message = json['message'] as String
  ..tenant = (json['tenant'] as List<dynamic>)
      .map((e) => Nodetenant.fromJson(e as Map<String, dynamic>))
      .toList()
  ..orgUnit = (json['orgUnit'] as List<dynamic>)
      .map((e) => Nodeorgunit.fromJson(e as Map<String, dynamic>))
      .toList()
  ..userMainId = json['userMainId'] as num
  ..tenantMainId = json['tenantMainId'] as num
  ..orgUnitMainId = json['orgUnitMainId'] as num
  ..phoneNumber = json['phoneNumber'] as String
  ..userName = json['userName'] as String
  ..firstName = json['firstName'] as String
  ..lastName = json['lastName'] as String
  ..profilePicuture = json['profilePicuture'] as String
  ..emailAddress = json['emailAddress'] as String
  ..accessToken = json['accessToken'] as String
  ..expireInSeconds = json['expireInSeconds'] as num
  ..expireDate = json['expireDate'] as String
  ..refreshToken = json['refreshToken'] as String
  ..refreshTokenExpireInSeconds = json['refreshTokenExpireInSeconds'] as num
  ..refreshTokenExpireDate = json['refreshTokenExpireDate'] as String;

Map<String, dynamic> _$LoginmodelToJson(Loginmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'tenant': instance.tenant,
      'orgUnit': instance.orgUnit,
      'userMainId': instance.userMainId,
      'tenantMainId': instance.tenantMainId,
      'orgUnitMainId': instance.orgUnitMainId,
      'phoneNumber': instance.phoneNumber,
      'userName': instance.userName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profilePicuture': instance.profilePicuture,
      'emailAddress': instance.emailAddress,
      'accessToken': instance.accessToken,
      'expireInSeconds': instance.expireInSeconds,
      'expireDate': instance.expireDate,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpireInSeconds': instance.refreshTokenExpireInSeconds,
      'refreshTokenExpireDate': instance.refreshTokenExpireDate,
    };

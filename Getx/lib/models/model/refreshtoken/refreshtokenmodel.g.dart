// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refreshtokenmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Refreshtokenmodel _$RefreshtokenmodelFromJson(Map<String, dynamic> json) =>
    Refreshtokenmodel()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..accessToken = json['accessToken'] as String
      ..expireInSeconds = json['expireInSeconds'] as num
      ..expireDate = json['expireDate'] as String
      ..refreshToken = json['refreshToken'] as String
      ..refreshTokenExpireInSeconds = json['refreshTokenExpireInSeconds'] as num
      ..refreshTokenExpireDate = json['refreshTokenExpireDate'] as String;

Map<String, dynamic> _$RefreshtokenmodelToJson(Refreshtokenmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'accessToken': instance.accessToken,
      'expireInSeconds': instance.expireInSeconds,
      'expireDate': instance.expireDate,
      'refreshToken': instance.refreshToken,
      'refreshTokenExpireInSeconds': instance.refreshTokenExpireInSeconds,
      'refreshTokenExpireDate': instance.refreshTokenExpireDate,
    };

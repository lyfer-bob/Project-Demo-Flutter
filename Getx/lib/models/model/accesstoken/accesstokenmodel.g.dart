// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accesstokenmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Accesstokenmodel _$AccesstokenmodelFromJson(Map<String, dynamic> json) =>
    Accesstokenmodel()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..accessToken = json['accessToken'] as String
      ..expireInSeconds = json['expireInSeconds'] as num
      ..expireDate = json['expireDate'] as String;

Map<String, dynamic> _$AccesstokenmodelToJson(Accesstokenmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'accessToken': instance.accessToken,
      'expireInSeconds': instance.expireInSeconds,
      'expireDate': instance.expireDate,
    };

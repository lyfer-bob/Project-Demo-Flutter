// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nodetenant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nodetenant _$NodetenantFromJson(Map<String, dynamic> json) => Nodetenant()
  ..tenantId = json['tenantId'] as num
  ..tenantName = json['tenantName'] as String
  ..userId = json['userId'] as num;

Map<String, dynamic> _$NodetenantToJson(Nodetenant instance) =>
    <String, dynamic>{
      'tenantId': instance.tenantId,
      'tenantName': instance.tenantName,
      'userId': instance.userId,
    };

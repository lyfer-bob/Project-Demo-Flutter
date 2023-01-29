// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aestmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aestmodel _$AestmodelFromJson(Map<String, dynamic> json) => Aestmodel()
  ..applicationId = json['applicationId'] as num
  ..applicationName = json['applicationName'] as String
  ..applicationPrefix = json['applicationPrefix'] as String
  ..applicationImage = json['applicationImage'] as num
  ..applicationOrder = json['applicationOrder'] as num
  ..applicationNotificationItem = json['applicationNotificationItem'] as bool
  ..permission = json['permission'] as String;

Map<String, dynamic> _$AestmodelToJson(Aestmodel instance) => <String, dynamic>{
      'applicationId': instance.applicationId,
      'applicationName': instance.applicationName,
      'applicationPrefix': instance.applicationPrefix,
      'applicationImage': instance.applicationImage,
      'applicationOrder': instance.applicationOrder,
      'applicationNotificationItem': instance.applicationNotificationItem,
      'permission': instance.permission,
    };

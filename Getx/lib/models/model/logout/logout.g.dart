// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Logout _$LogoutFromJson(Map<String, dynamic> json) => Logout()
  ..status = json['status'] as String
  ..message = json['message'] as String
  ..testInt = json['testInt'] as num
  ..testModel = json['testModel'] as bool
  ..testojb = Datatest.fromJson(json['testojb'] as Map<String, dynamic>);

Map<String, dynamic> _$LogoutToJson(Logout instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'testInt': instance.testInt,
      'testModel': instance.testModel,
      'testojb': instance.testojb,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Logout _$LogoutFromJson(Map<String, dynamic> json) => Logout()
  ..userId = json['userId'] as num
  ..userNameOrEmailAddress = json['userNameOrEmailAddress'] as String
  ..deviceId = json['deviceId'] as String;

Map<String, dynamic> _$LogoutToJson(Logout instance) => <String, dynamic>{
      'userId': instance.userId,
      'userNameOrEmailAddress': instance.userNameOrEmailAddress,
      'deviceId': instance.deviceId,
    };

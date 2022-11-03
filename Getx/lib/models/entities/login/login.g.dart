// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login()
  ..userNameOrEmailAddress = json['userNameOrEmailAddress'] as String
  ..password = json['password'] as String
  ..deviceId = json['deviceId'] as String
  ..deviceName = json['deviceName'] as String
  ..deviceOS = json['deviceOS'] as String;

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'userNameOrEmailAddress': instance.userNameOrEmailAddress,
      'password': instance.password,
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'deviceOS': instance.deviceOS,
    };

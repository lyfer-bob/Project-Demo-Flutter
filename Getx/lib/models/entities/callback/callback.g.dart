// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Callback _$CallbackFromJson(Map<String, dynamic> json) => Callback()
  ..transId = json['transId'] as String
  ..transRefNo = json['transRefNo'] as String
  ..applicationId = json['applicationId'] as String
  ..reqUserNameOrEmailAddress = json['reqUserNameOrEmailAddress'] as String
  ..transAmount = json['transAmount'] as num
  ..transStatus = json['transStatus'] as String
  ..transStatusReson = json['transStatusReson'] as String
  ..transStatusDate = json['transStatusDate'] as String
  ..approverEmail = json['approverEmail'] as String;

Map<String, dynamic> _$CallbackToJson(Callback instance) => <String, dynamic>{
      'transId': instance.transId,
      'transRefNo': instance.transRefNo,
      'applicationId': instance.applicationId,
      'reqUserNameOrEmailAddress': instance.reqUserNameOrEmailAddress,
      'transAmount': instance.transAmount,
      'transStatus': instance.transStatus,
      'transStatusReson': instance.transStatusReson,
      'transStatusDate': instance.transStatusDate,
      'approverEmail': instance.approverEmail,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canceldatatransaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Canceldatatransaction _$CanceldatatransactionFromJson(
        Map<String, dynamic> json) =>
    Canceldatatransaction()
      ..transId = json['transId'] as num
      ..transRefNo = json['transRefNo'] as String
      ..transStatus = json['transStatus'] as String
      ..transStatusReson = json['transStatusReson'] as String
      ..transStatusDate = json['transStatusDate'] as String
      ..approverEmail = json['approverEmail'] as String;

Map<String, dynamic> _$CanceldatatransactionToJson(
        Canceldatatransaction instance) =>
    <String, dynamic>{
      'transId': instance.transId,
      'transRefNo': instance.transRefNo,
      'transStatus': instance.transStatus,
      'transStatusReson': instance.transStatusReson,
      'transStatusDate': instance.transStatusDate,
      'approverEmail': instance.approverEmail,
    };

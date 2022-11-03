// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adddatatransactionmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Adddatatransactionmodel _$AdddatatransactionmodelFromJson(
        Map<String, dynamic> json) =>
    Adddatatransactionmodel()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..transId = json['transId'] as num
      ..transNumber = json['transNumber'] as String
      ..transRefNo = json['transRefNo'] as String;

Map<String, dynamic> _$AdddatatransactionmodelToJson(
        Adddatatransactionmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'transId': instance.transId,
      'transNumber': instance.transNumber,
      'transRefNo': instance.transRefNo,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaddatatransactionmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loaddatatransactionmodel _$LoaddatatransactionmodelFromJson(
        Map<String, dynamic> json) =>
    Loaddatatransactionmodel()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..DataTransaction = json['DataTransaction'] as List<dynamic>;

Map<String, dynamic> _$LoaddatatransactionmodelToJson(
        Loaddatatransactionmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'DataTransaction': instance.DataTransaction,
    };

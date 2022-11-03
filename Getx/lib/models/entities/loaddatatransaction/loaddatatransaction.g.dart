// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaddatatransaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loaddatatransaction _$LoaddatatransactionFromJson(Map<String, dynamic> json) =>
    Loaddatatransaction()
      ..userNameOrEmailAddress = json['userNameOrEmailAddress'] as String
      ..applicationId = json['applicationId'] as num
      ..filterText = json['filterText'] as String
      ..filter = (json['filter'] as List<dynamic>)
          .map((e) => Nodefilter.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$LoaddatatransactionToJson(
        Loaddatatransaction instance) =>
    <String, dynamic>{
      'userNameOrEmailAddress': instance.userNameOrEmailAddress,
      'applicationId': instance.applicationId,
      'filterText': instance.filterText,
      'filter': instance.filter,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nodetransapproved.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nodetransapproved _$NodetransapprovedFromJson(Map<String, dynamic> json) =>
    Nodetransapproved()
      ..Level = json['Level'] as num
      ..Name = json['Name'] as String
      ..Email = json['Email'] as String
      ..actionDate = json['actionDate'] as String
      ..actionStamp = json['actionStamp'] as String
      ..actionStampComment = json['actionStampComment'] as String;

Map<String, dynamic> _$NodetransapprovedToJson(Nodetransapproved instance) =>
    <String, dynamic>{
      'Level': instance.Level,
      'Name': instance.Name,
      'Email': instance.Email,
      'actionDate': instance.actionDate,
      'actionStamp': instance.actionStamp,
      'actionStampComment': instance.actionStampComment,
    };

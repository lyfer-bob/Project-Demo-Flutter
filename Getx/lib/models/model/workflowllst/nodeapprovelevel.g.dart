// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nodeapprovelevel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nodeapprovelevel _$NodeapprovelevelFromJson(Map<String, dynamic> json) =>
    Nodeapprovelevel()
      ..Level = json['Level'] as num
      ..Name = json['Name'] as String
      ..Email = json['Email'] as String
      ..Add = json['Add'] as String
      ..Edit = json['Edit'] as String
      ..View = json['View'] as String
      ..Approved = json['Approved'] as String
      ..Reject = json['Reject'] as String
      ..Delete = json['Delete'] as String;

Map<String, dynamic> _$NodeapprovelevelToJson(Nodeapprovelevel instance) =>
    <String, dynamic>{
      'Level': instance.Level,
      'Name': instance.Name,
      'Email': instance.Email,
      'Add': instance.Add,
      'Edit': instance.Edit,
      'View': instance.View,
      'Approved': instance.Approved,
      'Reject': instance.Reject,
      'Delete': instance.Delete,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflowllstmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workflowllstmodel _$WorkflowllstmodelFromJson(Map<String, dynamic> json) =>
    Workflowllstmodel()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..workflowList = json['workflowList'] as List<dynamic>;

Map<String, dynamic> _$WorkflowllstmodelToJson(Workflowllstmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'workflowList': instance.workflowList,
    };

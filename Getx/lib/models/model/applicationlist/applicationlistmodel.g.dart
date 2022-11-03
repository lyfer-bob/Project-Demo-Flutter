// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applicationlistmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Applicationlistmodel _$ApplicationlistmodelFromJson(
        Map<String, dynamic> json) =>
    Applicationlistmodel()
      ..status = json['status'] as String
      ..message = json['message'] as String
      ..applicationlist = (json['applicationlist'] as List<dynamic>)
          .map((e) => Nodeapplicationlist.fromJson(e as Map<String, dynamic>))
          .toList()
      ..nodeapplicationojb = Nodeapplicationojb.fromJson(
          json['nodeapplicationojb'] as Map<String, dynamic>);

Map<String, dynamic> _$ApplicationlistmodelToJson(
        Applicationlistmodel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'applicationlist': instance.applicationlist,
      'nodeapplicationojb': instance.nodeapplicationojb,
    };

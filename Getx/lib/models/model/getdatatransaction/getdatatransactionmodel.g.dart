// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getdatatransactionmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getdatatransactionmodel _$GetdatatransactionmodelFromJson(
        Map<String, dynamic> json) =>
    Getdatatransactionmodel()
      ..transId = json['transId'] as String
      ..transRefNo = json['transRefNo'] as String
      ..applicationId = json['applicationId'] as String
      ..reqUserNameOrEmailAddress = json['reqUserNameOrEmailAddress'] as String
      ..transCategorycode = json['transCategorycode'] as String
      ..transData1 = json['transData1'] as String
      ..transData2 = json['transData2'] as String
      ..transData3 = json['transData3'] as String
      ..transData4 = json['transData4'] as String
      ..transData5 = json['transData5'] as String
      ..transData6 = json['transData6'] as String
      ..transData7 = json['transData7'] as String
      ..transData8 = json['transData8'] as String
      ..transData9 = json['transData9'] as String
      ..transData10 = json['transData10'] as String
      ..transDataHtml = json['transDataHtml'] as String
      ..transAmount = json['transAmount'] as num
      ..transImage = json['transImage'] as String
      ..transDocument = json['transDocument'] as String
      ..transStartDate = json['transStartDate'] as String
      ..transEndDate = json['transEndDate'] as String
      ..transStatus = json['transStatus'] as String
      ..transStatusReson = json['transStatusReson'] as String
      ..transStatusDate = json['transStatusDate'] as String
      ..approverEmail = json['approverEmail'] as String
      ..urlCallback = json['urlCallback'] as String
      ..workflowId = json['workflowId'] as String
      ..currentApprover = json['currentApprover'] as String
      ..transApproved = (json['transApproved'] as List<dynamic>)
          .map((e) => Nodetransapproved.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetdatatransactionmodelToJson(
        Getdatatransactionmodel instance) =>
    <String, dynamic>{
      'transId': instance.transId,
      'transRefNo': instance.transRefNo,
      'applicationId': instance.applicationId,
      'reqUserNameOrEmailAddress': instance.reqUserNameOrEmailAddress,
      'transCategorycode': instance.transCategorycode,
      'transData1': instance.transData1,
      'transData2': instance.transData2,
      'transData3': instance.transData3,
      'transData4': instance.transData4,
      'transData5': instance.transData5,
      'transData6': instance.transData6,
      'transData7': instance.transData7,
      'transData8': instance.transData8,
      'transData9': instance.transData9,
      'transData10': instance.transData10,
      'transDataHtml': instance.transDataHtml,
      'transAmount': instance.transAmount,
      'transImage': instance.transImage,
      'transDocument': instance.transDocument,
      'transStartDate': instance.transStartDate,
      'transEndDate': instance.transEndDate,
      'transStatus': instance.transStatus,
      'transStatusReson': instance.transStatusReson,
      'transStatusDate': instance.transStatusDate,
      'approverEmail': instance.approverEmail,
      'urlCallback': instance.urlCallback,
      'workflowId': instance.workflowId,
      'currentApprover': instance.currentApprover,
      'transApproved': instance.transApproved,
    };

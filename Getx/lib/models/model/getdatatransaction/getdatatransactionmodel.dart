import 'package:json_annotation/json_annotation.dart';
import "nodetransapproved.dart";
part 'getdatatransactionmodel.g.dart';

@JsonSerializable()
class Getdatatransactionmodel {
  Getdatatransactionmodel();

  late String transId;
  late String transRefNo;
  late String applicationId;
  late String reqUserNameOrEmailAddress;
  late String transCategorycode;
  late String transData1;
  late String transData2;
  late String transData3;
  late String transData4;
  late String transData5;
  late String transData6;
  late String transData7;
  late String transData8;
  late String transData9;
  late String transData10;
  late String transDataHtml;
  late num transAmount;
  late String transImage;
  late String transDocument;
  late String transStartDate;
  late String transEndDate;
  late String transStatus;
  late String transStatusReson;
  late String transStatusDate;
  late String approverEmail;
  late String urlCallback;
  late String workflowId;
  late String currentApprover;
  late List<Nodetransapproved> transApproved;
  
  factory Getdatatransactionmodel.fromJson(Map<String,dynamic> json) => _$GetdatatransactionmodelFromJson(json);
  Map<String, dynamic> toJson() => _$GetdatatransactionmodelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'canceldatatransaction.g.dart';

@JsonSerializable()
class Canceldatatransaction {
  Canceldatatransaction();

  late num transId;
  late String transRefNo;
  late String transStatus;
  late String transStatusReson;
  late String transStatusDate;
  late String approverEmail;
  
  factory Canceldatatransaction.fromJson(Map<String,dynamic> json) => _$CanceldatatransactionFromJson(json);
  Map<String, dynamic> toJson() => _$CanceldatatransactionToJson(this);
}

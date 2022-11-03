import 'package:json_annotation/json_annotation.dart';

part 'savedatatransaction.g.dart';

@JsonSerializable()
class Savedatatransaction {
  Savedatatransaction();

  late num transId;
  late String transRefNo;
  late String transStatus;
  late String transStatusReson;
  late String transStatusDate;
  late String approverEmail;
  
  factory Savedatatransaction.fromJson(Map<String,dynamic> json) => _$SavedatatransactionFromJson(json);
  Map<String, dynamic> toJson() => _$SavedatatransactionToJson(this);
}

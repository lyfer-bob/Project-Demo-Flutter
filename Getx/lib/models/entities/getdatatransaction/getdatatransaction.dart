import 'package:json_annotation/json_annotation.dart';

part 'getdatatransaction.g.dart';

@JsonSerializable()
class Getdatatransaction {
  Getdatatransaction();

  late num transId;
  late String transRefNo;
  
  factory Getdatatransaction.fromJson(Map<String,dynamic> json) => _$GetdatatransactionFromJson(json);
  Map<String, dynamic> toJson() => _$GetdatatransactionToJson(this);
}

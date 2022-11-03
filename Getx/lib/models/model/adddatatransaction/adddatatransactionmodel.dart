import 'package:json_annotation/json_annotation.dart';

part 'adddatatransactionmodel.g.dart';

@JsonSerializable()
class Adddatatransactionmodel {
  Adddatatransactionmodel();

  late String status;
  late String message;
  late num transId;
  late String transNumber;
  late String transRefNo;
  
  factory Adddatatransactionmodel.fromJson(Map<String,dynamic> json) => _$AdddatatransactionmodelFromJson(json);
  Map<String, dynamic> toJson() => _$AdddatatransactionmodelToJson(this);
}

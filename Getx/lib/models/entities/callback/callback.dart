import 'package:json_annotation/json_annotation.dart';

part 'callback.g.dart';

@JsonSerializable()
class Callback {
  Callback();

  late String transId;
  late String transRefNo;
  late String applicationId;
  late String reqUserNameOrEmailAddress;
  late num transAmount;
  late String transStatus;
  late String transStatusReson;
  late String transStatusDate;
  late String approverEmail;
  
  factory Callback.fromJson(Map<String,dynamic> json) => _$CallbackFromJson(json);
  Map<String, dynamic> toJson() => _$CallbackToJson(this);
}

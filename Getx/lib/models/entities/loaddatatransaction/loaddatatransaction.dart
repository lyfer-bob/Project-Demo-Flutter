import 'package:json_annotation/json_annotation.dart';
import "nodefilter.dart";
part 'loaddatatransaction.g.dart';

@JsonSerializable()
class Loaddatatransaction {
  Loaddatatransaction();

  late String userNameOrEmailAddress;
  late num applicationId;
  late String filterText;
  late List<Nodefilter> filter;
  
  factory Loaddatatransaction.fromJson(Map<String,dynamic> json) => _$LoaddatatransactionFromJson(json);
  Map<String, dynamic> toJson() => _$LoaddatatransactionToJson(this);
}

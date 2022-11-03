import 'package:json_annotation/json_annotation.dart';

part 'nodeacctionstatus.g.dart';

@JsonSerializable()
class Nodeacctionstatus {
  Nodeacctionstatus();

  late String actionCode;
  late String actionName;
  
  factory Nodeacctionstatus.fromJson(Map<String,dynamic> json) => _$NodeacctionstatusFromJson(json);
  Map<String, dynamic> toJson() => _$NodeacctionstatusToJson(this);
}

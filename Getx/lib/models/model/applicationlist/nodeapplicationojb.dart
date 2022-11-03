import 'package:json_annotation/json_annotation.dart';

part 'nodeapplicationojb.g.dart';

@JsonSerializable()
class Nodeapplicationojb {
  Nodeapplicationojb();

  late num applicationId;
  late String applicationName;
  
  factory Nodeapplicationojb.fromJson(Map<String,dynamic> json) => _$NodeapplicationojbFromJson(json);
  Map<String, dynamic> toJson() => _$NodeapplicationojbToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'nodetenant.g.dart';

@JsonSerializable()
class Nodetenant {
  Nodetenant();

  late num tenantId;
  late String tenantName;
  late num userId;
  
  factory Nodetenant.fromJson(Map<String,dynamic> json) => _$NodetenantFromJson(json);
  Map<String, dynamic> toJson() => _$NodetenantToJson(this);
}

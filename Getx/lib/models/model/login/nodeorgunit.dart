import 'package:json_annotation/json_annotation.dart';

part 'nodeorgunit.g.dart';

@JsonSerializable()
class Nodeorgunit {
  Nodeorgunit();

  late num orgUnitId;
  late String orgUnitName;
  
  factory Nodeorgunit.fromJson(Map<String,dynamic> json) => _$NodeorgunitFromJson(json);
  Map<String, dynamic> toJson() => _$NodeorgunitToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'datatest.g.dart';

@JsonSerializable()
class Datatest {
  Datatest();

  late String eieieiei;
  late String eieieieiaaa;
  late num eieieieiabbbbbb;
  
  factory Datatest.fromJson(Map<String,dynamic> json) => _$DatatestFromJson(json);
  Map<String, dynamic> toJson() => _$DatatestToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'nodefilter.g.dart';

@JsonSerializable()
class Nodefilter {
  Nodefilter();

  late String categoryCode;
  late String categoryValue;
  
  factory Nodefilter.fromJson(Map<String,dynamic> json) => _$NodefilterFromJson(json);
  Map<String, dynamic> toJson() => _$NodefilterToJson(this);
}

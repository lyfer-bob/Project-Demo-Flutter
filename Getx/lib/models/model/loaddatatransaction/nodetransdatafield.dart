import 'package:json_annotation/json_annotation.dart';

part 'nodetransdatafield.g.dart';

@JsonSerializable()
class Nodetransdatafield {
  Nodetransdatafield();

  late String transDataTitle;
  late String transDataValue;
  late String transDataOrder;
  
  factory Nodetransdatafield.fromJson(Map<String,dynamic> json) => _$NodetransdatafieldFromJson(json);
  Map<String, dynamic> toJson() => _$NodetransdatafieldToJson(this);
}

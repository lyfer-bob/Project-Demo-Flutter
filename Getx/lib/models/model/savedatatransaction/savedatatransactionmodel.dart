import 'package:json_annotation/json_annotation.dart';

part 'savedatatransactionmodel.g.dart';

@JsonSerializable()
class Savedatatransactionmodel {
  Savedatatransactionmodel();

  late String status;
  late String message;
  
  factory Savedatatransactionmodel.fromJson(Map<String,dynamic> json) => _$SavedatatransactionmodelFromJson(json);
  Map<String, dynamic> toJson() => _$SavedatatransactionmodelToJson(this);
}

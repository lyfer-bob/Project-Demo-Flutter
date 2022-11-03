import 'package:json_annotation/json_annotation.dart';

part 'canceldatatransactionmodel.g.dart';

@JsonSerializable()
class Canceldatatransactionmodel {
  Canceldatatransactionmodel();

  late String status;
  late String message;
  
  factory Canceldatatransactionmodel.fromJson(Map<String,dynamic> json) => _$CanceldatatransactionmodelFromJson(json);
  Map<String, dynamic> toJson() => _$CanceldatatransactionmodelToJson(this);
}

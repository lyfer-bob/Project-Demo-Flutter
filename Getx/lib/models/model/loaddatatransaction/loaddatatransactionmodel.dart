import 'package:json_annotation/json_annotation.dart';

part 'loaddatatransactionmodel.g.dart';

@JsonSerializable()
class Loaddatatransactionmodel {
  Loaddatatransactionmodel();

  late String status;
  late String message;
  late List DataTransaction;
  
  factory Loaddatatransactionmodel.fromJson(Map<String,dynamic> json) => _$LoaddatatransactionmodelFromJson(json);
  Map<String, dynamic> toJson() => _$LoaddatatransactionmodelToJson(this);
}

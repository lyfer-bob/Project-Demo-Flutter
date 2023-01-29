import 'package:json_annotation/json_annotation.dart';
import "aestmodel.dart";
part 'applicationlistmodel.g.dart';

@JsonSerializable()
class Applicationlistmodel {
  Applicationlistmodel();

  late String status;
  late String message;
  late List<Aestmodel> applicationlist;
  Map<String,dynamic>? point;
  
  factory Applicationlistmodel.fromJson(Map<String,dynamic> json) => _$ApplicationlistmodelFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationlistmodelToJson(this);
}

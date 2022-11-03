import 'package:json_annotation/json_annotation.dart';
import "nodeapplicationlist.dart";
import "nodeapplicationojb.dart";
part 'applicationlistmodel.g.dart';

@JsonSerializable()
class Applicationlistmodel {
  Applicationlistmodel();

  late String status;
  late String message;
  late List<Nodeapplicationlist> applicationlist;
  late Nodeapplicationojb nodeapplicationojb;
  
  factory Applicationlistmodel.fromJson(Map<String,dynamic> json) => _$ApplicationlistmodelFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationlistmodelToJson(this);
}

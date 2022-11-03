import 'package:json_annotation/json_annotation.dart';

part 'nodeapprovelevel.g.dart';

@JsonSerializable()
class Nodeapprovelevel {
  Nodeapprovelevel();

  late num Level;
  late String Name;
  late String Email;
  late String Add;
  late String Edit;
  late String View;
  late String Approved;
  late String Reject;
  late String Delete;
  
  factory Nodeapprovelevel.fromJson(Map<String,dynamic> json) => _$NodeapprovelevelFromJson(json);
  Map<String, dynamic> toJson() => _$NodeapprovelevelToJson(this);
}

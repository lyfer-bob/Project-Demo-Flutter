import 'package:json_annotation/json_annotation.dart';

part 'nodetransapproved.g.dart';

@JsonSerializable()
class Nodetransapproved {
  Nodetransapproved();

  late num Level;
  late String Name;
  late String Email;
  late String actionDate;
  late String actionStamp;
  late String actionStampComment;
  
  factory Nodetransapproved.fromJson(Map<String,dynamic> json) => _$NodetransapprovedFromJson(json);
  Map<String, dynamic> toJson() => _$NodetransapprovedToJson(this);
}

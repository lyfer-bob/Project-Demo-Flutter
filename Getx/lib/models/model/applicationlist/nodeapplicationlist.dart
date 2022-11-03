import 'package:json_annotation/json_annotation.dart';

part 'nodeapplicationlist.g.dart';

@JsonSerializable()
class Nodeapplicationlist {
  Nodeapplicationlist();

  late num applicationId;
  late String applicationName;
  late String applicationPrefix;
  late num applicationImage;
  late num applicationOrder;
  late bool applicationNotificationItem;
  late String permission;
  
  factory Nodeapplicationlist.fromJson(Map<String,dynamic> json) => _$NodeapplicationlistFromJson(json);
  Map<String, dynamic> toJson() => _$NodeapplicationlistToJson(this);
}

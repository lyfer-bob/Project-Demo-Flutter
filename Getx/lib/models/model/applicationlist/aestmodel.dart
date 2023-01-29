import 'package:json_annotation/json_annotation.dart';

part 'aestmodel.g.dart';

@JsonSerializable()
class Aestmodel {
  Aestmodel();

  late num applicationId;
  late String applicationName;
  late String applicationPrefix;
  late num applicationImage;
  late num applicationOrder;
  late bool applicationNotificationItem;
  late String permission;
  
  factory Aestmodel.fromJson(Map<String,dynamic> json) => _$AestmodelFromJson(json);
  Map<String, dynamic> toJson() => _$AestmodelToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'workflowllstmodel.g.dart';

@JsonSerializable()
class Workflowllstmodel {
  Workflowllstmodel();

  late String status;
  late String message;
  late List workflowList;
  
  factory Workflowllstmodel.fromJson(Map<String,dynamic> json) => _$WorkflowllstmodelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkflowllstmodelToJson(this);
}

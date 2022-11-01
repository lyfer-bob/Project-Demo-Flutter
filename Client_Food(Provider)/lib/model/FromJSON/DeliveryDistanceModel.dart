class DeliveryDistanceModel {
  String? status;
  Result? result;

  DeliveryDistanceModel({this.status, this.result});

  DeliveryDistanceModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  String? status;
  String? deliverDistance;
  String? timeMap;

  Result({this.success, this.status, this.deliverDistance, this.timeMap});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.status = json["status"];
    this.deliverDistance = json["deliver_distance"];
    this.timeMap = json["time_map"];
  }
}

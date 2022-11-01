class CheckDistanceModel {
  String? status;
  Result? result;

  CheckDistanceModel({this.status, this.result});

  CheckDistanceModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? distance;
  String? storeNear;
  bool? success;

  Result({this.distance, this.storeNear, this.success});

  Result.fromJson(Map<String, dynamic> json) {
    this.distance = json["distance"];
    this.storeNear = json["storeNear"];
    this.success = json["success"];
  }
}

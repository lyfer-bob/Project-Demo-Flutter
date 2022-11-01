class GetLocationModel {
  String? status;
  Result? result;

  GetLocationModel({this.status, this.result});

  GetLocationModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  String? address;

  Result({this.success, this.address});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.address = json["address"];
  }
}

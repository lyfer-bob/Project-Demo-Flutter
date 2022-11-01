class MasterAmphurModel {
  Result? result;

  MasterAmphurModel({this.result});

  MasterAmphurModel.fromJson(Map<String, dynamic> json) {
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<DetailDistrict>? detailDistrict;
  String? errorCode;
  String? message;
  int? status;
  String? success;
  dynamic? transId;

  Result(
      {this.detailDistrict,
      this.errorCode,
      this.message,
      this.status,
      this.success,
      this.transId});

  Result.fromJson(Map<String, dynamic> json) {
    this.detailDistrict = json["DetailDistrict"] == null
        ? null
        : (json["DetailDistrict"] as List)
            .map((e) => DetailDistrict.fromJson(e))
            .toList();
    this.errorCode = json["error_code"];
    this.message = json["message"];
    this.status = json["status"];
    this.success = json["success"];
    this.transId = json["trans_id"];
  }
}

class DetailDistrict {
  String? cityName;
  int? id;
  int? stateId;
  String? status;

  DetailDistrict({this.cityName, this.id, this.stateId, this.status});

  DetailDistrict.fromJson(Map<String, dynamic> json) {
    this.cityName = json["city_name"];
    this.id = json["id"];
    this.stateId = json["state_id"];
    this.status = json["status"];
  }
}

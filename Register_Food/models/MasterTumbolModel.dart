class MasterTumbolModel {
  Result? result;

  MasterTumbolModel({this.result});

  MasterTumbolModel.fromJson(Map<String, dynamic> json) {
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<DetailSubDistrict>? detailSubDistrict;
  dynamic? errorCode;
  String? message;
  int? status;
  dynamic? success;
  dynamic? transId;

  Result(
      {this.detailSubDistrict,
      this.errorCode,
      this.message,
      this.status,
      this.success,
      this.transId});

  Result.fromJson(Map<String, dynamic> json) {
    this.detailSubDistrict = json["DetailSubDistrict"] == null
        ? null
        : (json["DetailSubDistrict"] as List)
            .map((e) => DetailSubDistrict.fromJson(e))
            .toList();
    this.errorCode = json["error_code"];
    this.message = json["message"];
    this.status = json["status"];
    this.success = json["success"];
    this.transId = json["trans_id"];
  }
}

class DetailSubDistrict {
  String? areaName;
  int? cityId;
  int? id;
  int? stateId;
  String? status;
  String? zipcode;

  DetailSubDistrict(
      {this.areaName,
      this.cityId,
      this.id,
      this.stateId,
      this.status,
      this.zipcode});

  DetailSubDistrict.fromJson(Map<String, dynamic> json) {
    this.areaName = json["area_name"];
    this.cityId = json["city_id"];
    this.id = json["id"];
    this.stateId = json["state_id"];
    this.status = json["status"];
    this.zipcode = json["zipcode"];
  }
}

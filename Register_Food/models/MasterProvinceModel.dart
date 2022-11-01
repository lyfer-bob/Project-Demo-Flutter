class MasterProvinceModel {
  Result? result;

  MasterProvinceModel({this.result});

  MasterProvinceModel.fromJson(Map<String, dynamic> json) {
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<DetailProvince>? detailProvince;
  String? errorCode;
  String? message;
  int? status;
  String? success;
  dynamic? transId;

  Result(
      {this.detailProvince,
      this.errorCode,
      this.message,
      this.status,
      this.success,
      this.transId});

  Result.fromJson(Map<String, dynamic> json) {
    this.detailProvince = json["DetailProvince"] == null
        ? null
        : (json["DetailProvince"] as List)
            .map((e) => DetailProvince.fromJson(e))
            .toList();
    this.errorCode = json["error_code"];
    this.message = json["message"];
    this.status = json["status"];
    this.success = json["success"];
    this.transId = json["trans_id"];
  }
}

class DetailProvince {
  bool? areaRider;
  String? deleteStatus;
  int? id;
  String? stateCode;
  String? stateName;
  String? stateNameEng;
  String? status;

  DetailProvince(
      {this.areaRider,
      this.deleteStatus,
      this.id,
      this.stateCode,
      this.stateName,
      this.stateNameEng,
      this.status});

  DetailProvince.fromJson(Map<String, dynamic> json) {
    this.areaRider = json["area_rider"];
    this.deleteStatus = json["delete_status"];
    this.id = json["id"];
    this.stateCode = json["state_code"];
    this.stateName = json["state_name"];
    this.stateNameEng = json["state_name_eng"];
    this.status = json["status"];
  }


}

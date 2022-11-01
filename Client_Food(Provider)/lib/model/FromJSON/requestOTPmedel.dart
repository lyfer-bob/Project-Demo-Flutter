class RequestOTPMedel {
  String? status;
  Result? result;

  RequestOTPMedel({
      this.status, 
      this.result});

  RequestOTPMedel.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  int? success;
  String? pinId;

  Result({
      this.success, 
      this.pinId});

  Result.fromJson(dynamic json) {
    success = json['success'];
    pinId = json['pin_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['success'] = success;
    map['pin_id'] = pinId;
    return map;
  }

}
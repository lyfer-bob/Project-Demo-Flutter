class RequestOTPLoginModel {
  RequestOTPLoginModel({
      this.status, 
      this.result,});

  RequestOTPLoginModel.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? status;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

class Result {
  Result({
      this.success, 
      this.phoneNumber, 
      this.pinId,});

  Result.fromJson(dynamic json) {
    success = json['success'];
    phoneNumber = json['PhoneNumber'];
    pinId = json['pin_id'];
  }
  int? success;
  String? phoneNumber;
  String? pinId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['PhoneNumber'] = phoneNumber;
    map['pin_id'] = pinId;
    return map;
  }

}
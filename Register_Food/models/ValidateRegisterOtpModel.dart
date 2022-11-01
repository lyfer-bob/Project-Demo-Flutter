/// response : {"result":{"error_code":"","message":"otp verified successfully","phone_number":"0958043660","register_id":"","success":"1","trans_id":"2022040514491503"},"status":"OK"}

class ValidateRegisterOtpModel {
  ValidateRegisterOtpModel({
      this.response,});

  ValidateRegisterOtpModel.fromJson(dynamic json) {
    response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  Response? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.toJson();
    }
    return map;
  }

}

/// result : {"error_code":"","message":"otp verified successfully","phone_number":"0958043660","register_id":"","success":"1","trans_id":"2022040514491503"}
/// status : "OK"

class Response {
  Response({
      this.result, 
      this.status,});

  Response.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
  }
  Result? result;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

/// error_code : ""
/// message : "otp verified successfully"
/// phone_number : "0958043660"
/// register_id : ""
/// success : "1"
/// trans_id : "2022040514491503"

class Result {
  Result({
      this.errorCode, 
      this.message, 
      this.phoneNumber, 
      this.registerId, 
      this.success, 
      this.transId,});

  Result.fromJson(dynamic json) {
    errorCode = json['error_code'];
    message = json['message'];
    phoneNumber = json['phone_number'];
    registerId = json['register_id'];
    success = json['success'];
    transId = json['trans_id'];
  }
  String? errorCode;
  String? message;
  String? phoneNumber;
  String? registerId;
  String? success;
  String? transId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error_code'] = errorCode;
    map['message'] = message;
    map['phone_number'] = phoneNumber;
    map['register_id'] = registerId;
    map['success'] = success;
    map['trans_id'] = transId;
    return map;
  }

}
/// response : {"result":{"message":"","otp_expire":"01/07/2022 16:43:26","pin_code":"429931","ref_code":"8ZZIB","success":"1","trans_id":"2022040514491500"},"status":"OK"}

class RequestRegisterOtpModel {
  RequestRegisterOtpModel({
    this.response,
  });

  RequestRegisterOtpModel.fromJson(dynamic json) {
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
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

/// result : {"message":"","otp_expire":"01/07/2022 16:43:26","pin_code":"429931","ref_code":"8ZZIB","success":"1","trans_id":"2022040514491500"}
/// status : "OK"

class Response {
  Response({
    this.result,
    this.status,
  });

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

/// message : ""
/// otp_expire : "01/07/2022 16:43:26"
/// pin_code : "429931"
/// ref_code : "8ZZIB"
/// success : "1"
/// trans_id : "2022040514491500"

class Result {
  Result({
    this.message,
    this.otpExpire,
    this.pinCode,
    this.refCode,
    this.success,
    this.transId,
  });

  Result.fromJson(dynamic json) {
    message = json['message'].toString();
    otpExpire = json['otp_expire'].toString();
    pinCode = json['pin_code'].toString();
    refCode = json['ref_code'].toString();
    success = json['success'].toString();
    transId = json['trans_id'].toString();
  }
  String? message;
  String? otpExpire;
  String? pinCode;
  String? refCode;
  String? success;
  String? transId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['otp_expire'] = otpExpire;
    map['pin_code'] = pinCode;
    map['ref_code'] = refCode;
    map['success'] = success;
    map['trans_id'] = transId;
    return map;
  }
}

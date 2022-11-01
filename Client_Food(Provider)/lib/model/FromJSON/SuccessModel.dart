class SuccessModel {
  String? status;
  Result? result;

  SuccessModel({this.status, this.result});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? success;
  String? message;
  String? verifyotp;

  Result({this.success, this.message, this.verifyotp});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"].toString();
    this.message = json["message"];
    this.verifyotp = json["verifyotp"].toString();
  }
}

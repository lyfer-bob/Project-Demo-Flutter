class ForgetPasswordModel {
  String? status;
  Result? result;

  ForgetPasswordModel({
      this.status, 
      this.result});

  ForgetPasswordModel.fromJson(dynamic json) {
    status = json["status"];
    result = json["result"] != null ? Result.fromJson(json["result"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = status;
    if (result != null) {
      map["result"] = result?.toJson();
    }
    return map;
  }

}

class Result {
  String? message;
  int? success;

  Result({
      this.message, 
      this.success});

  Result.fromJson(dynamic json) {
    message = json["message"];
    success = json["success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    map["success"] = success;
    return map;
  }

}
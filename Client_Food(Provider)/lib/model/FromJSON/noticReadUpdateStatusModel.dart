class NoticReadUpdateStatusModel {
  String? status;
  Result? result;

  NoticReadUpdateStatusModel({this.status, this.result});

  NoticReadUpdateStatusModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["status"] = this.status;
    if (this.result != null) data["result"] = this.result!.toJson();
    return data;
  }
}

class Result {
  String? success;
  String? message;

  Result({this.success, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    data["message"] = this.message;
    return data;
  }
}

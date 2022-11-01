class PolicyModel {
  String? status;
  Result? result;

  PolicyModel({this.status, this.result});

  PolicyModel.fromJson(Map<String, dynamic> json) {
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
  String? value;

  Result({this.success, this.value});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    data["value"] = this.value;
    return data;
  }
}

class NoticCountModel {
  String? status;
  Result? result;

  NoticCountModel({
    this.status,
    this.result,
  });

  NoticCountModel.fromJson(Map<String, dynamic> json) {
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
  int? success;
  int? notifyUnreadCount;

  Result({
    this.success,
    this.notifyUnreadCount,
  });

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.notifyUnreadCount = json["NotifyUnreadCount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    data["NotifyUnreadCount"] = this.notifyUnreadCount;
    return data;
  }
}

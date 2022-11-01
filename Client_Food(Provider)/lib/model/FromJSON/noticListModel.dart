class ListNoticModel {
  String? status;
  Result? result;

  ListNoticModel({
    this.status,
    this.result,
  });

  ListNoticModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  String? message;
  int? totalItem;
  List<Items>? items;

  Result({
    this.success,
    this.message,
    this.totalItem,
    this.items,
  });

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.message = json["message"];
    this.totalItem = json["total_item"];
    this.items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
  }
}

class Items {
  int? id;
  String? date;
  String? subject;
  String? title;
  Content? content;
  String? contentAll;
  String? url;
  bool? statusRead;
  int? orderId;
  int? typeId;
  String? typeName;

  Items(
      {this.id,
      this.date,
      this.subject,
      this.content,
      this.title,
      this.contentAll,
      this.url,
      this.statusRead,
      this.orderId,
      this.typeId,
      this.typeName});

  Items.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.date = json["date"];
    this.title = json["title"];
    this.subject = json["subject"];
    this.contentAll = json["content"];
    this.content = json["contentobj"] == null
        ? null
        : Content.fromJson(json["contentobj"]);
    this.url = json["url"];
    this.statusRead = json["status_read"];
    this.orderId = json["order_id"];
    this.typeId = json["typeID"];
    this.typeName = json["typeName"];
  }
}

class Content {
  String? header;
  String? orderNumber;
  String? status;
  String? reason;

  Content({
    this.header,
    this.orderNumber,
    this.status,
    this.reason,
  });

  Content.fromJson(Map<String, dynamic> json) {
    this.header = json["header"];
    this.orderNumber = json["orderNumber"];
    this.status = json["status"];
    this.reason = json["reason"];
  }
}

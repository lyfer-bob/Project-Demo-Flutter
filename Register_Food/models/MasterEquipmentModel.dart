class MasterEquipmentModel {
  Response? response;

  MasterEquipmentModel({this.response});

  MasterEquipmentModel.fromJson(Map<String, dynamic> json) {
    this.response =
        json["response"] == null ? null : Response.fromJson(json["response"]);
  }
}

class Response {
  List<DetailEquipment>? detailEquipment;
  String? errorCode;
  String? message;
  int? status;
  String? success;
  String? transId;

  Response(
      {this.detailEquipment,
      this.errorCode,
      this.message,
      this.status,
      this.success,
      this.transId});

  Response.fromJson(Map<String, dynamic> json) {
    this.detailEquipment = json["DetailEquipment"] == null
        ? null
        : (json["DetailEquipment"] as List)
            .map((e) => DetailEquipment.fromJson(e))
            .toList();
    this.errorCode = json["error_code"];
    this.message = json["message"];
    this.status = json["status"];
    this.success = json["success"];
    this.transId = json["trans_id"];
  }
}

class DetailEquipment {
  String? itemId;
  String? itemName;
  String? itemStatus;

  DetailEquipment({this.itemId, this.itemName, this.itemStatus});

  DetailEquipment.fromJson(Map<String, dynamic> json) {
    this.itemId = json["ItemID"];
    this.itemName = json["ItemName"];
    this.itemStatus = json["ItemStatus"];
  }
}

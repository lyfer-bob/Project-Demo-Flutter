class MasterBankModel {
  Result? result;

  MasterBankModel({this.result});

  MasterBankModel.fromJson(Map<String, dynamic> json) {
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<DetailBank>? detailBank;
  String? errorCode;
  String? message;
  int? status;
  String? success;
  String? transId;

  Result(
      {this.detailBank,
      this.errorCode,
      this.message,
      this.status,
      this.success,
      this.transId});

  Result.fromJson(Map<String, dynamic> json) {
    this.detailBank = json["DetailBank"] == null
        ? null
        : (json["DetailBank"] as List)
            .map((e) => DetailBank.fromJson(e))
            .toList();
    this.errorCode = json["error_code"];
    this.message = json["message"];
    this.status = json["status"];
    this.success = json["success"];
    this.transId = json["trans_id"];
  }
}

class DetailBank {
  String? id;
  String? nameen;
  String? nameth;
  String? status;

  DetailBank({this.id, this.nameen, this.nameth, this.status});

  DetailBank.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.nameen = json["nameen"];
    this.nameth = json["nameth"];
    this.status = json["status"];
  }
}

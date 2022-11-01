class GetListBankingModel {
  String? status;
  Result? result;

  GetListBankingModel({this.status, this.result});

  GetListBankingModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  List<Banks>? banks;

  Result({this.success, this.banks});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.banks = json["banks"] == null
        ? null
        : (json["banks"] as List).map((e) => Banks.fromJson(e)).toList();
  }
}

class Banks {
  String? name;
  String? img;
  String? source;
  bool? status;

  Banks({this.name, this.img, this.source, this.status});

  Banks.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.img = json["img"];
    this.source = json["source"];
  }
}

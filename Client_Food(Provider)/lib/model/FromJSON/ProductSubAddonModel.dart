class ProductSubAddonModel {
  String? status;
  Result? result;

  ProductSubAddonModel({this.status, this.result});

  ProductSubAddonModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? success;
  List<ProductAddons>? productAddons;

  Result({this.success, this.productAddons});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"].toString();
    this.productAddons = json["productAddons"] == null
        ? null
        : (json["productAddons"] as List)
            .map((e) => ProductAddons.fromJson(e))
            .toList();
  }
}

class ProductAddons {
  int? id;
  String? subaddonsName;
  int? subaddonsPrice;
  bool? statusSelect;

  ProductAddons(
      {this.id, this.subaddonsName, this.subaddonsPrice, this.statusSelect});

  ProductAddons.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.subaddonsName = json["subaddons_name"];
    this.subaddonsPrice = json["subaddons_price"];
  }
}

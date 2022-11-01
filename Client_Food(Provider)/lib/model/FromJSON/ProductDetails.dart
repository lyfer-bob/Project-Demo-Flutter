class ProductDetailsModel {
  String? status;
  Result? result;

  ProductDetailsModel({this.status, this.result});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  ProductDetails? productDetails;

  Result({this.success, this.productDetails});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.productDetails = json["productDetails"] == null
        ? null
        : ProductDetails.fromJson(json["productDetails"]);
  }
}

class ProductDetails {
  Details? details;
  List<Variants>? variants;
  List<MainAddon>? mainAddon;

  ProductDetails({this.details, this.variants, this.mainAddon});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    this.details =
        json["Details"] == null ? null : Details.fromJson(json["Details"]);
    this.variants = json["variants"] == null
        ? null
        : (json["variants"] as List).map((e) => Variants.fromJson(e)).toList();
    this.mainAddon = json["MainAddon"] == null
        ? null
        : (json["MainAddon"] as List)
            .map((e) => MainAddon.fromJson(e))
            .toList();
  }
}

class MainAddon {
  int? mainaddonsId;
  String? mainaddonsName;
  int? mainaddonsMiniCount;
  int? mainaddonsCount;
  bool? status;

  MainAddon(
      {this.mainaddonsId,
      this.mainaddonsName,
      this.mainaddonsMiniCount,
      this.mainaddonsCount});

  MainAddon.fromJson(Map<String, dynamic> json) {
    this.mainaddonsId = json["mainaddons_id"];
    this.mainaddonsName = json["mainaddons_name"];
    this.mainaddonsMiniCount = json["mainaddons_mini_count"];
    this.mainaddonsCount = json["mainaddons_count"];
  }
}

class Variants {
  int? id;
  int? menuId;
  String? subName;
  int? orginalPrice;
  String? created;
  String? modified;

  Variants(
      {this.id,
      this.menuId,
      this.subName,
      this.orginalPrice,
      this.created,
      this.modified});

  Variants.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.menuId = json["menu_id"];
    this.subName = json["sub_name"];
    this.orginalPrice = json["orginal_price"];
    this.created = json["created"];
    this.modified = json["modified"];
  }
}

class Details {
  int? id;
  int? restaurantId;
  int? categoryId;
  String? menuName;
  String? priceOption;
  String? menuDescription;
  String? menuImage;
  String? menuType;
  String? menuAddon;
  String? popularDish;
  String? spicyDish;
  String? favourite;
  String? recommendMenuStatus;
  int? sortorder;
  String? status;
  String? deleteStatus;
  String? created;
  String? modified;
  List<MenuDetails>? menuDetails;

  Details(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.menuName,
      this.priceOption,
      this.menuDescription,
      this.menuImage,
      this.menuType,
      this.menuAddon,
      this.popularDish,
      this.spicyDish,
      this.favourite,
      this.recommendMenuStatus,
      this.sortorder,
      this.status,
      this.deleteStatus,
      this.created,
      this.modified,
      this.menuDetails});

  Details.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.restaurantId = json["restaurant_id"];
    this.categoryId = json["category_id"];
    this.menuName = json["menu_name"];
    this.priceOption = json["price_option"];
    this.menuDescription = json["menu_description"];
    this.menuImage = json["menu_image"];
    this.menuType = json["menu_type"];
    this.menuAddon = json["menu_addon"];
    this.popularDish = json["popular_dish"];
    this.spicyDish = json["spicy_dish"];
    this.favourite = json["favourite"];
    this.recommendMenuStatus = json["recommend_menu_status"];
    this.sortorder = json["sortorder"];
    this.status = json["status"];
    this.deleteStatus = json["delete_status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.menuDetails = json["menu_details"] == null
        ? null
        : (json["menu_details"] as List)
            .map((e) => MenuDetails.fromJson(e))
            .toList();
  }
}

class MenuDetails {
  int? id;
  int? menuId;
  String? subName;
  int? orginalPrice;
  String? created;
  String? modified;
  int? statuSelected;

  MenuDetails(
      {this.id,
      this.menuId,
      this.subName,
      this.orginalPrice,
      this.created,
      this.modified,
      this.statuSelected});

  MenuDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.menuId = json["menu_id"];
    this.subName = json["sub_name"];
    this.orginalPrice = json["orginal_price"];
    this.created = json["created"];
    this.modified = json["modified"];
  }
}

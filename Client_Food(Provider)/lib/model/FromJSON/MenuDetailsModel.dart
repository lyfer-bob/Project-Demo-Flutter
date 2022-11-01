class MenuDetailsModel {
  String? status;
  Result? result;

  MenuDetailsModel({this.status, this.result});

  MenuDetailsModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  OffersDiscount? offersDiscount;
  RestDetails? restDetails;
  List<CategoryList2>? categoryList2;
  List<RecommendMenusList>? recommendMenusList;
  List<OrderListAll>? orderListAll;
  int? success;

  Result(
      {this.offersDiscount,
      this.restDetails,
      this.categoryList2,
      this.recommendMenusList,
      this.orderListAll,
      this.success});

  Result.fromJson(Map<String, dynamic> json) {
    this.offersDiscount = json["OffersDiscount"] == null
        ? null
        : OffersDiscount.fromJson(json["OffersDiscount"]);
    this.restDetails = json["restDetails"] == null
        ? null
        : RestDetails.fromJson(json["restDetails"]);
    this.categoryList2 = json["categoryList2"] == null
        ? null
        : (json["categoryList2"] as List)
            .map((e) => CategoryList2.fromJson(e))
            .toList();
    this.recommendMenusList = json["recommendMenusList"] == null
        ? null
        : (json["recommendMenusList"] as List)
            .map((e) => RecommendMenusList.fromJson(e))
            .toList();
    this.orderListAll = json["orderListAll"] == null
        ? null
        : (json["orderListAll"] as List)
            .map((e) => OrderListAll.fromJson(e))
            .toList();

    this.success = json["success"];
  }
}

class OffersDiscount {
  String? offerId;
  String? offerPercentage;
  String? offerMinPrice;
  String? offerMaxPrice;
  String? firstUser;
  String? offerFrom;
  String? offerTo;
  bool? offerStatus;

  OffersDiscount(
      {this.offerId,
      this.offerPercentage,
      this.offerMinPrice,
      this.offerMaxPrice,
      this.firstUser,
      this.offerFrom,
      this.offerTo,
      this.offerStatus});

  OffersDiscount.fromJson(Map<String, dynamic> json) {
    this.offerId = json["offer_id"].toString();
    this.offerPercentage = json["offer_percentage"].toString();
    this.offerMinPrice = json["offer_min_price"].toString();
    this.offerMaxPrice = json["offer_max_price"].toString();
    this.firstUser = json["first_user"];
    this.offerFrom = json["offer_from"];
    this.offerTo = json["offer_to"];
    this.offerStatus = json["offer_status"];
  }
}

class OrderListAll {
  String? id;
  String? menuName;
  String? menuDescription;
  String? menuImage;
  String? menuPrice;
  String? categoryName;
  String? recommendMenuStatus;

  OrderListAll(
      {this.id,
      this.menuName,
      this.menuDescription,
      this.menuImage,
      this.recommendMenuStatus,
      this.categoryName,
      this.menuPrice});

  OrderListAll.fromJson(Map<String, dynamic> json) {
    this.id = json["id"].toString();
    this.menuName = json["menu_name"];
    this.menuPrice = json["menu_price"].toString();
    this.menuDescription = json["menu_description"];
    this.categoryName = json["category_name"];
    this.menuImage = json["menu_image"];
    this.recommendMenuStatus = json["recommend_menu_status"].toString();
  }
}

class RecommendMenusList {
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
  int? createdBy;
  dynamic modifiedBy;
  List<MenuDetails2>? menuDetails;

  RecommendMenusList(
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
      this.createdBy,
      this.modifiedBy,
      this.menuDetails});

  RecommendMenusList.fromJson(Map<String, dynamic> json) {
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
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.menuDetails = json["menu_details"] == null
        ? null
        : (json["menu_details"] as List)
            .map((e) => MenuDetails2.fromJson(e))
            .toList();
  }
}

class MenuDetails2 {
  int? id;
  int? menuId;
  String? subName;
  double? orginalPrice;
  String? created;
  String? modified;
  int? createdBy;
  dynamic modifiedBy;

  MenuDetails2(
      {this.id,
      this.menuId,
      this.subName,
      this.orginalPrice,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy});

  MenuDetails2.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.menuId = json["menu_id"];
    this.subName = json["sub_name"];
    this.orginalPrice = double.parse(json["orginal_price"].toString());
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
  }
}

class CategoryList2 {
  int? id;
  String? name;

  CategoryList2({this.id, this.name});

  CategoryList2.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
  }
}

class RestDetails {
  int? id;
  int? userId;
  String? contactName;
  String? contactPhone;
  String? contactEmail;
  String? contactAddress;
  String? sourcelatitude;
  String? sourcelongitude;
  String? streetAddress;
  int? stateId;
  int? cityId;
  int? locationId;
  String? restaurantName;
  String? seoUrl;
  String? restaurantPhone;
  String? mondayFirstOpentime;
  String? mondayFirstClosetime;
  String? mondaySecondOpentime;
  String? mondaySecondClosetime;
  String? tuesdayFirstOpentime;
  String? tuesdayFirstClosetime;
  String? tuesdaySecondOpentime;
  String? tuesdaySecondClosetime;
  String? wednesdayFirstOpentime;
  String? wednesdayFirstClosetime;
  String? wednesdaySecondOpentime;
  String? wednesdaySecondClosetime;
  String? thursdayFirstOpentime;
  String? thursdayFirstClosetime;
  String? thursdaySecondOpentime;
  String? thursdaySecondClosetime;
  String? fridayFirstOpentime;
  String? fridayFirstClosetime;
  String? fridaySecondOpentime;
  String? fridaySecondClosetime;
  String? saturdayFirstOpentime;
  String? saturdayFirstClosetime;
  String? saturdaySecondOpentime;
  String? saturdaySecondClosetime;
  String? sundayFirstOpentime;
  String? sundayFirstClosetime;
  String? sundaySecondOpentime;
  String? sundaySecondClosetime;
  String? mondayStatus;
  String? tuesdayStatus;
  String? wednesdayStatus;
  String? thursdayStatus;
  String? fridayStatus;
  String? saturdayStatus;
  String? sundayStatus;
  int? restaurantTax;
  String? restaurantCuisine;
  String? restaurantVisibility;
  String? restaurantDispatch;
  String? restaurantPickup;
  String? restaurantDelivery;
  String? restaurantBooktable;
  String? pickupTime;
  String? restaurantAbout;
  String? username;
  String? estimateTime;
  double? minimumOrder;
  int? freeDelivery;
  String? mapMode;
  String? emailOrder;
  String? orderEmail;
  String? smsOption;
  String? smsPhonenumber;
  int? restaurantCommission;
  String? invoicePeriod;
  String? metaTitle;
  String? metaKeyword;
  String? metaDescription;
  String? restaurantLogo;
  String? logoName;
  String? isLogged;
  String? deviceName;
  String? deviceId;
  String? fbPageId;
  String? rewardOption;
  String? status;
  String? deleteStatus;
  String? created;
  String? modified;
  int? createdBy;
  int? modifiedBy;
  String? startDate;
  String? recommend;
  String? resNumber;
  String? restaurantPos;
  String? restaurantPosUrl;
  String? statusReceiveOrder;
  List<RestaurantPayments>? restaurantPayments;
  List<Offers>? offers;
  List<Reviews>? reviews;
  List<RestaurantMenus>? restaurantMenus;
  String? rewardText;
  String? rewardPoint;
  String? rewardPerc;
  int? rewardMinBuy;
  int? rewardMaxPrice;
  String? firstUser;
  int? favourite;
  String? currentStatus;
  String? cuisineLists;
  String? cuisineRecord;
  String? distance;
  int? deliveryCharge;
  int? totalRating;
  double? finalReview;
  List<MenusDetails>? menusDetails;

  RestDetails(
      {this.id,
      this.userId,
      this.contactName,
      this.contactPhone,
      this.contactEmail,
      this.contactAddress,
      this.sourcelatitude,
      this.sourcelongitude,
      this.streetAddress,
      this.stateId,
      this.cityId,
      this.locationId,
      this.restaurantName,
      this.seoUrl,
      this.restaurantPhone,
      this.mondayFirstOpentime,
      this.mondayFirstClosetime,
      this.mondaySecondOpentime,
      this.mondaySecondClosetime,
      this.tuesdayFirstOpentime,
      this.tuesdayFirstClosetime,
      this.tuesdaySecondOpentime,
      this.tuesdaySecondClosetime,
      this.wednesdayFirstOpentime,
      this.wednesdayFirstClosetime,
      this.wednesdaySecondOpentime,
      this.wednesdaySecondClosetime,
      this.thursdayFirstOpentime,
      this.thursdayFirstClosetime,
      this.thursdaySecondOpentime,
      this.thursdaySecondClosetime,
      this.fridayFirstOpentime,
      this.fridayFirstClosetime,
      this.fridaySecondOpentime,
      this.fridaySecondClosetime,
      this.saturdayFirstOpentime,
      this.saturdayFirstClosetime,
      this.saturdaySecondOpentime,
      this.saturdaySecondClosetime,
      this.sundayFirstOpentime,
      this.sundayFirstClosetime,
      this.sundaySecondOpentime,
      this.sundaySecondClosetime,
      this.mondayStatus,
      this.tuesdayStatus,
      this.wednesdayStatus,
      this.thursdayStatus,
      this.fridayStatus,
      this.saturdayStatus,
      this.sundayStatus,
      this.restaurantTax,
      this.restaurantCuisine,
      this.restaurantVisibility,
      this.restaurantDispatch,
      this.restaurantPickup,
      this.restaurantDelivery,
      this.restaurantBooktable,
      this.pickupTime,
      this.restaurantAbout,
      this.username,
      this.estimateTime,
      this.minimumOrder,
      this.freeDelivery,
      this.mapMode,
      this.emailOrder,
      this.orderEmail,
      this.smsOption,
      this.smsPhonenumber,
      this.restaurantCommission,
      this.invoicePeriod,
      this.metaTitle,
      this.metaKeyword,
      this.metaDescription,
      this.restaurantLogo,
      this.logoName,
      this.isLogged,
      this.deviceName,
      this.deviceId,
      this.fbPageId,
      this.rewardOption,
      this.status,
      this.deleteStatus,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy,
      this.startDate,
      this.recommend,
      this.resNumber,
      this.restaurantPos,
      this.restaurantPosUrl,
      this.statusReceiveOrder,
      this.restaurantPayments,
      this.offers,
      this.reviews,
      this.restaurantMenus,
      this.rewardText,
      this.rewardPoint,
      this.rewardPerc,
      this.rewardMinBuy,
      this.rewardMaxPrice,
      this.firstUser,
      this.favourite,
      this.currentStatus,
      this.cuisineLists,
      this.cuisineRecord,
      this.distance,
      this.deliveryCharge,
      this.totalRating,
      this.finalReview,
      this.menusDetails});

  RestDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userId = json["user_id"];
    this.contactName = json["contact_name"];
    this.contactPhone = json["contact_phone"];
    this.contactEmail = json["contact_email"];
    this.contactAddress = json["contact_address"];
    this.sourcelatitude = json["sourcelatitude"];
    this.sourcelongitude = json["sourcelongitude"];
    this.streetAddress = json["street_address"];
    this.stateId = json["state_id"];
    this.cityId = json["city_id"];
    this.locationId = json["location_id"];
    this.restaurantName = json["restaurant_name"];
    this.seoUrl = json["seo_url"];
    this.restaurantPhone = json["restaurant_phone"];
    this.mondayFirstOpentime = json["monday_first_opentime"];
    this.mondayFirstClosetime = json["monday_first_closetime"];
    this.mondaySecondOpentime = json["monday_second_opentime"];
    this.mondaySecondClosetime = json["monday_second_closetime"];
    this.tuesdayFirstOpentime = json["tuesday_first_opentime"];
    this.tuesdayFirstClosetime = json["tuesday_first_closetime"];
    this.tuesdaySecondOpentime = json["tuesday_second_opentime"];
    this.tuesdaySecondClosetime = json["tuesday_second_closetime"];
    this.wednesdayFirstOpentime = json["wednesday_first_opentime"];
    this.wednesdayFirstClosetime = json["wednesday_first_closetime"];
    this.wednesdaySecondOpentime = json["wednesday_second_opentime"];
    this.wednesdaySecondClosetime = json["wednesday_second_closetime"];
    this.thursdayFirstOpentime = json["thursday_first_opentime"];
    this.thursdayFirstClosetime = json["thursday_first_closetime"];
    this.thursdaySecondOpentime = json["thursday_second_opentime"];
    this.thursdaySecondClosetime = json["thursday_second_closetime"];
    this.fridayFirstOpentime = json["friday_first_opentime"];
    this.fridayFirstClosetime = json["friday_first_closetime"];
    this.fridaySecondOpentime = json["friday_second_opentime"];
    this.fridaySecondClosetime = json["friday_second_closetime"];
    this.saturdayFirstOpentime = json["saturday_first_opentime"];
    this.saturdayFirstClosetime = json["saturday_first_closetime"];
    this.saturdaySecondOpentime = json["saturday_second_opentime"];
    this.saturdaySecondClosetime = json["saturday_second_closetime"];
    this.sundayFirstOpentime = json["sunday_first_opentime"];
    this.sundayFirstClosetime = json["sunday_first_closetime"];
    this.sundaySecondOpentime = json["sunday_second_opentime"];
    this.sundaySecondClosetime = json["sunday_second_closetime"];
    this.mondayStatus = json["monday_status"];
    this.tuesdayStatus = json["tuesday_status"];
    this.wednesdayStatus = json["wednesday_status"];
    this.thursdayStatus = json["thursday_status"];
    this.fridayStatus = json["friday_status"];
    this.saturdayStatus = json["saturday_status"];
    this.sundayStatus = json["sunday_status"];
    this.restaurantTax = json["restaurant_tax"];
    this.restaurantCuisine = json["restaurant_cuisine"];
    this.restaurantVisibility = json["restaurant_visibility"];
    this.restaurantDispatch = json["restaurant_dispatch"];
    this.restaurantPickup = json["restaurant_pickup"];
    this.restaurantDelivery = json["restaurant_delivery"];
    this.restaurantBooktable = json["restaurant_booktable"];
    this.pickupTime = json["pickup_time"];
    this.restaurantAbout = json["restaurant_about"];
    this.username = json["username"];
    this.estimateTime = json["estimate_time"];
    this.minimumOrder = double.parse(json["minimum_order"].toString());
    this.freeDelivery = json["free_delivery"];
    this.mapMode = json["map_mode"];
    this.emailOrder = json["email_order"];
    this.orderEmail = json["order_email"];
    this.smsOption = json["sms_option"];
    this.smsPhonenumber = json["sms_phonenumber"];
    this.restaurantCommission = json["restaurant_commission"];
    this.invoicePeriod = json["invoice_period"];
    this.metaTitle = json["meta_title"];
    this.metaKeyword = json["meta_keyword"];
    this.metaDescription = json["meta_description"];
    this.restaurantLogo = json["restaurant_logo"];
    this.logoName = json["logo_name"];
    this.isLogged = json["is_logged"];
    this.deviceName = json["device_name"];
    this.deviceId = json["device_id"];
    this.fbPageId = json["fb_page_id"];
    this.rewardOption = json["reward_option"];
    this.status = json["status"];
    this.deleteStatus = json["delete_status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.startDate = json["start_date"];
    this.recommend = json["recommend"];
    this.resNumber = json["res_number"];
    this.restaurantPos = json["restaurant_pos"];
    this.restaurantPosUrl = json["restaurant_pos_url"];
    this.statusReceiveOrder = json["status_receive_order"];
    this.restaurantPayments = json["restaurant_payments"] == null
        ? null
        : (json["restaurant_payments"] as List)
            .map((e) => RestaurantPayments.fromJson(e))
            .toList();
    this.offers = json["offers"] == null
        ? null
        : (json["offers"] as List).map((e) => Offers.fromJson(e)).toList();
    this.reviews = json["reviews"] == null
        ? null
        : (json["reviews"] as List).map((e) => Reviews.fromJson(e)).toList();
    this.restaurantMenus = json["restaurant_menus"] == null
        ? null
        : (json["restaurant_menus"] as List)
            .map((e) => RestaurantMenus.fromJson(e))
            .toList();

    this.rewardText = json["reward_text"];
    this.rewardPoint = json["reward_point"].toString();
    this.rewardPerc = json["reward_perc"].toString();
    this.rewardMinBuy = json["reward_minBuy"];
    this.rewardMaxPrice = json["reward_maxPrice"];
    this.firstUser = json["first_user"];
    this.favourite = json["favourite"];
    this.currentStatus = json["currentStatus"];
    this.cuisineLists = json["cuisineLists"];
    this.cuisineRecord = json["cuisineRecord"];
    this.distance = json["distance"];
    this.deliveryCharge = json["delivery_charge"];
    this.totalRating = json["totalRating"];
    this.finalReview = double.parse(json["finalReview"].toString());
    this.menusDetails = json["menusDetails"] == null
        ? null
        : (json["menusDetails"] as List)
            .map((e) => MenusDetails.fromJson(e))
            .toList();
  }
}

class MenusDetails {
  String? categoryName;
  int? categoryId;
  String? status;
  String? deleteStatus;
  List<Menu1>? menu;

  MenusDetails(
      {this.categoryName,
      this.categoryId,
      this.status,
      this.deleteStatus,
      this.menu});

  MenusDetails.fromJson(Map<String, dynamic> json) {
    this.categoryName = json["category_name"];
    this.categoryId = json["category_id"];
    this.status = json["status"];
    this.deleteStatus = json["delete_status"];
    this.menu = json["menu"] == null
        ? null
        : (json["menu"] as List).map((e) => Menu1.fromJson(e)).toList();
  }
}

class Menu1 {
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
  int? createdBy;
  dynamic modifiedBy;
  List<MenuDetails1>? menuDetails;

  Menu1(
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
      this.createdBy,
      this.modifiedBy,
      this.menuDetails});

  Menu1.fromJson(Map<String, dynamic> json) {
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
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.menuDetails = json["menu_details"] == null
        ? null
        : (json["menu_details"] as List)
            .map((e) => MenuDetails1.fromJson(e))
            .toList();
  }
}

class MenuDetails1 {
  int? id;
  int? menuId;
  String? subName;
  int? orginalPrice;
  String? created;
  String? modified;
  int? createdBy;
  dynamic modifiedBy;

  MenuDetails1(
      {this.id,
      this.menuId,
      this.subName,
      this.orginalPrice,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy});

  MenuDetails1.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.menuId = json["menu_id"];
    this.subName = json["sub_name"];
    this.orginalPrice = json["orginal_price"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
  }
}

class RestaurantMenus {
  int? id;
  int? restaurantId;
  int? categoryId;
  String? categoryName;
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
  int? createdBy;
  dynamic modifiedBy;
  List<Menu>? menu;

  RestaurantMenus(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.categoryName,
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
      this.createdBy,
      this.modifiedBy,
      this.menu});

  RestaurantMenus.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.restaurantId = json["restaurant_id"];
    this.categoryId = json["category_id"];
    this.categoryName = json["category_name"];
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
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.menu = json["menu"] == null
        ? null
        : (json["menu"] as List).map((e) => Menu.fromJson(e)).toList();
  }
}

class Menu {
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
  int? createdBy;
  dynamic modifiedBy;
  List<MenuDetails>? menuDetails;

  Menu(
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
      this.createdBy,
      this.modifiedBy,
      this.menuDetails});

  Menu.fromJson(Map<String, dynamic> json) {
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
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
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
  double? orginalPrice;
  String? created;
  String? modified;
  int? createdBy;
  dynamic modifiedBy;

  MenuDetails(
      {this.id,
      this.menuId,
      this.subName,
      this.orginalPrice,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy});

  MenuDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.menuId = json["menu_id"];
    this.subName = json["sub_name"];
    this.orginalPrice = double.parse(json["orginal_price"].toString());
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
  }
}

class Offers {
  int? id;
  int? resid;
  String? firstUser;
  String? normal;
  String? deliveryMode;
  int? freePercentage;
  int? freePrice;
  int? normalPercentage;
  int? normalPrice;
  String? offerPercentage;
  String? offerPrice;
  String? offerFrom;
  String? offerTo;
  String? status;
  String? created;
  String? modified;
  String? offersText;

  Offers(
      {this.id,
      this.resid,
      this.firstUser,
      this.normal,
      this.deliveryMode,
      this.freePercentage,
      this.freePrice,
      this.normalPercentage,
      this.normalPrice,
      this.offerPercentage,
      this.offerPrice,
      this.offerFrom,
      this.offerTo,
      this.status,
      this.created,
      this.modified,
      this.offersText});

  Offers.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.resid = json["resid"];
    this.firstUser = json["first_user"];
    this.normal = json["normal"];
    this.deliveryMode = json["delivery_mode"];
    this.freePercentage = json["free_percentage"];
    this.freePrice = json["free_price"];
    this.normalPercentage = json["normal_percentage"];
    this.normalPrice = json["normal_price"];
    this.offerPercentage = json["offer_percentage"];
    this.offerPrice = json["offer_price"];
    this.offerFrom = json["offer_from"];
    this.offerTo = json["offer_to"];
    this.status = json["status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.offersText = json["offers_text"];
  }
}

class Reviews {
  int? id;
  int? orderId;
  int? restaurantId;
  int? customerId;
  int? rating;
  String? message;
  String? status;
  String? deleteStatus;
  String? created;
  String? modified;
  dynamic createdBy;
  dynamic modifiedBy;
  int? ratingDriver;
  int? driverId;
  String? statusDriver;
  String? driverDeleteStatus;
  User? user;

  Reviews(
      {this.id,
      this.orderId,
      this.restaurantId,
      this.customerId,
      this.rating,
      this.message,
      this.status,
      this.deleteStatus,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy,
      this.ratingDriver,
      this.driverId,
      this.statusDriver,
      this.driverDeleteStatus,
      this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.orderId = json["order_id"];
    this.restaurantId = json["restaurant_id"];
    this.customerId = json["customer_id"];
    this.rating = json["rating"];
    this.message = json["message"];
    this.status = json["status"];
    this.deleteStatus = json["delete_status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.ratingDriver = json["rating_driver"];
    this.driverId = json["driver_id"];
    this.statusDriver = json["status_driver"];
    this.driverDeleteStatus = json["driver_delete_status"];
    this.user = json["user"] == null ? null : User.fromJson(json["user"]);
  }
}

class User {
  String? firstName;
  String? lastName;
  String? fullname;

  User({this.firstName, this.lastName, this.fullname});

  User.fromJson(Map<String, dynamic> json) {
    this.firstName = json["first_name"];
    this.lastName = json["last_name"];
    this.fullname = '${this.firstName} ${this.lastName}';
  }
}

class RestaurantPayments {
  int? id;
  int? restaurantId;
  int? paymentId;
  String? paymentStatus;
  String? created;
  String? modified;
  dynamic createdBy;
  dynamic modifiedBy;
  PaymentMethod? paymentMethod;

  RestaurantPayments(
      {this.id,
      this.restaurantId,
      this.paymentId,
      this.paymentStatus,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy,
      this.paymentMethod});

  RestaurantPayments.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.restaurantId = json["restaurant_id"];
    this.paymentId = json["payment_id"];
    this.paymentStatus = json["payment_status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.paymentMethod = json["payment_method"] == null
        ? null
        : PaymentMethod.fromJson(json["payment_method"]);
  }
}

class PaymentMethod {
  int? id;
  String? paymentMethodName;
  String? paymentMethodImage;
  int? status;
  String? created;
  String? modified;
  dynamic createdBy;
  dynamic modifiedBy;

  PaymentMethod(
      {this.id,
      this.paymentMethodName,
      this.paymentMethodImage,
      this.status,
      this.created,
      this.modified,
      this.createdBy,
      this.modifiedBy});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.paymentMethodName = json["payment_method_name"];
    this.paymentMethodImage = json["payment_method_image"];
    this.status = json["status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
  }
}

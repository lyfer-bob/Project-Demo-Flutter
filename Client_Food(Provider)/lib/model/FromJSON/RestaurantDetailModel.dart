class RestaurantDetailModel {
  String? status;
  Result? result;

  RestaurantDetailModel({this.status, this.result});

  RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<RestaurantLists>? restaurantLists;
  String? currentDay;
  int? success;

  Result({this.restaurantLists, this.currentDay, this.success});

  Result.fromJson(Map<String, dynamic> json) {
    this.restaurantLists = json["restaurantLists"] == null
        ? null
        : (json["restaurantLists"] as List)
            .map((e) => RestaurantLists.fromJson(e))
            .toList();
    this.currentDay = json["currentDay"];
    this.success = json["success"];
  }
}

class RestaurantLists {
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
  int? minimumOrder;
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
  List<RestaurantPayments>? restaurantPayments;
  List<Promotions>? promotions;
  List<Offers>? offers;
  List<Reviews>? reviews;
  List<RestaurantMenus>? restaurantMenus;
  String? toDistance;
  int? deliveryCharge;
  RestOffers? restOffers;
  int? totalRating;
  double? finalReview;
  String? firstUser;
  String? currentStatus;
  String? cuisineLists;

  RestaurantLists(
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
      this.restaurantPayments,
      this.promotions,
      this.offers,
      this.reviews,
      this.restaurantMenus,
      this.toDistance,
      this.deliveryCharge,
      this.restOffers,
      this.totalRating,
      this.finalReview,
      this.firstUser,
      this.currentStatus,
      this.cuisineLists});

  RestaurantLists.fromJson(Map<String, dynamic> json) {
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
    this.minimumOrder = json["minimum_order"];
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
    this.restaurantPayments = json["restaurant_payments"] == null
        ? null
        : (json["restaurant_payments"] as List)
            .map((e) => RestaurantPayments.fromJson(e))
            .toList();
    this.promotions = json["promotions"] == null
        ? null
        : (json["promotions"] as List)
            .map((e) => Promotions.fromJson(e))
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
    this.toDistance = json["to_distance"];
    this.deliveryCharge = json["delivery_charge"];
    this.restOffers = json["restOffers"] == null
        ? null
        : RestOffers.fromJson(json["restOffers"]);
    this.totalRating = json["totalRating"];
    this.finalReview = json["finalReview"];
    this.firstUser = json["first_user"];
    this.currentStatus = json["currentStatus"];
    this.cuisineLists = json["cuisineLists"];
  }
}

class RestOffers {
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

  RestOffers(
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
      this.modified});

  RestOffers.fromJson(Map<String, dynamic> json) {
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
  }
}

class RestaurantMenus {
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

  RestaurantMenus(
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
      this.modified});

  RestaurantMenus.fromJson(Map<String, dynamic> json) {
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
  String? customerName;

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
      this.customerName});

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
    this.customerName = json["customer_name"];
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
      this.modified});

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
  }
}

class Promotions {
  int? id;
  int? restaurantId;
  String? promoImage;
  String? promoImageUrl;
  String? cuisineList;
  String? toDistance;
  int? deliveryCharge;

  Promotions(
      {this.id,
      this.restaurantId,
      this.promoImage,
      this.promoImageUrl,
      this.cuisineList,
      this.toDistance,
      this.deliveryCharge});

  Promotions.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.restaurantId = json["restaurant_id"];
    this.promoImage = json["promo_image"];
    this.promoImageUrl = json["promo_image_url"];
    this.cuisineList = json["cuisineList"];
    this.toDistance = json["to_distance"];
    this.deliveryCharge = json["delivery_charge"];
  }
}

class RestaurantPayments {
  int? id;
  int? restaurantId;
  int? paymentId;
  String? paymentStatus;
  String? created;
  String? modified;
  PaymentMethod? paymentMethod;

  RestaurantPayments(
      {this.id,
      this.restaurantId,
      this.paymentId,
      this.paymentStatus,
      this.created,
      this.modified,
      this.paymentMethod});

  RestaurantPayments.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.restaurantId = json["restaurant_id"];
    this.paymentId = json["payment_id"];
    this.paymentStatus = json["payment_status"];
    this.created = json["created"];
    this.modified = json["modified"];
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

  PaymentMethod(
      {this.id,
      this.paymentMethodName,
      this.paymentMethodImage,
      this.status,
      this.created,
      this.modified});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.paymentMethodName = json["payment_method_name"];
    this.paymentMethodImage = json["payment_method_image"];
    this.status = json["status"];
    this.created = json["created"];
    this.modified = json["modified"];
  }
}

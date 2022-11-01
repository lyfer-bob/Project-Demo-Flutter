class FavoriteListModelNew {
  String? status;
  Result? result;

  FavoriteListModelNew({this.status, this.result});

  FavoriteListModelNew.fromJson(dynamic json) {
    status = json['status'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
}

class Result {
  List<RestaurantLists>? restaurantLists;
  String? success;
  String? message;
  String? currentDay;

  Result({this.restaurantLists, this.success, this.message, this.currentDay});

  Result.fromJson(dynamic json) {
    if (json['restaurantLists'] != null) {
      restaurantLists = [];
      json['restaurantLists'].forEach((v) {
        restaurantLists!.add(RestaurantLists.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
    currentDay = json['currentDay'];
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
  String? restaurantPhone;
  String? restaurantCuisine;
  String? restaurantAbout;
  String? username;
  String? estimateTime;
  int? minimumOrder;
  int? freeDelivery;
  String? rewardOption;
  String? status;
  String? deleteStatus;
  String? created;
  String? modified;
  List<Offers>? offers;
  dynamic addressBooksLat;
  dynamic addressBooksLon;
  String? toDistance;
  String? deliveryCharge;
  String? messageCharge;
  int? totalRating;
  double? finalReview;
  String? firstUser;
  String? currentStatus;
  String? cuisineLists;
  String? restaurantLogo;
  String? logoName;
  String? promotionTitle;
  RestOffer? restOffer;

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
      this.restaurantPhone,
      this.restaurantCuisine,
      this.restaurantAbout,
      this.username,
      this.estimateTime,
      this.minimumOrder,
      this.freeDelivery,
      this.rewardOption,
      this.status,
      this.deleteStatus,
      this.created,
      this.modified,
      this.offers,
      this.addressBooksLat,
      this.addressBooksLon,
      this.toDistance,
      this.deliveryCharge,
      this.messageCharge,
      this.totalRating,
      this.finalReview,
      this.firstUser,
      this.currentStatus,
      this.cuisineLists,
      this.restaurantLogo,
      this.logoName,
      this.promotionTitle,
      this.restOffer});

  RestaurantLists.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    contactAddress = json['contact_address'];
    sourcelatitude = json['sourcelatitude'];
    sourcelongitude = json['sourcelongitude'];
    streetAddress = json['street_address'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    locationId = json['location_id'];
    restaurantName = json['restaurant_name'];
    restaurantPhone = json['restaurant_phone'];
    restaurantCuisine = json['restaurant_cuisine'];
    restaurantAbout = json['restaurant_about'];
    username = json['username'];
    estimateTime = json['estimate_time'];
    minimumOrder = json['minimum_order'];
    freeDelivery = json['free_delivery'];
    rewardOption = json['reward_option'];
    status = json['status'];
    deleteStatus = json['delete_status'];
    created = json['created'];
    modified = json['modified'];
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers?.add(Offers.fromJson(v));
      });
    }
    addressBooksLat = json['addressBooksLat'];
    addressBooksLon = json['addressBooksLon'];
    toDistance = json['to_distance'];
    deliveryCharge = json['delivery_charge'].toString();
    messageCharge = json['messageCharge'];

    this.restOffer = json["restOffer"] == null
        ? null
        : RestOffer.fromJson(json["restOffer"]);

    totalRating = json['totalRating'];
    finalReview = double.parse(json['finalReview'].toString());
    firstUser = json['first_user'];
    currentStatus = json['currentStatus'];
    cuisineLists = json['cuisineLists'];
    restaurantLogo = json['restaurant_logo'];
    logoName = json['logo_name'];
    promotionTitle = json['promotion_title'];
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

  Offers.fromJson(dynamic json) {
    id = json['id'];
    resid = json['resid'];
    firstUser = json['first_user'];
    normal = json['normal'];
    deliveryMode = json['delivery_mode'];
    freePercentage = json['free_percentage'];
    freePrice = json['free_price'];
    normalPercentage = json['normal_percentage'];
    normalPrice = json['normal_price'];
    offerPercentage = json['offer_percentage'];
    offerPrice = json['offer_price'];
    offerFrom = json['offer_from'];
    offerTo = json['offer_to'];
    status = json['status'];
    created = json['created'];
    modified = json['modified'];
  }
}

class RestOffer {
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

  RestOffer(
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

  RestOffer.fromJson(Map<String, dynamic> json) {
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

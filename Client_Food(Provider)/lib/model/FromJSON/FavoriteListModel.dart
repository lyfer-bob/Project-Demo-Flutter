class FavoriteListModel {
  Result? result;
  String? status;

  FavoriteListModel({this.result, this.status});

  FavoriteListModel.fromJson(Map<String, dynamic> json) {
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
    this.status = json["status"];
  }
}

class Result {
  String? success;
  String? message;
  List<RestaurantLists>? restaurantLists;
  String? currentDay;

  Result({this.success, this.message, this.restaurantLists, this.currentDay});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.message = json["message"];
    this.restaurantLists = json["restaurantLists"] == null
        ? null
        : (json["restaurantLists"] as List)
            .map((e) => RestaurantLists.fromJson(e))
            .toList();
    this.currentDay = json["currentDay"];
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
  String? pickupTime;
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
  // List<Offers>? offers;
  String? toDistance;
  String? deliveryCharge;
  // List<RestOffers>? restOffers;
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
      this.restaurantPhone,
      this.restaurantCuisine,
      this.pickupTime,
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
      // this.offers,
      this.toDistance,
      this.deliveryCharge,
      // this.restOffers,
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
    this.restaurantPhone = json["restaurant_phone"];
    this.restaurantCuisine = json["restaurant_cuisine"];
    this.pickupTime = json["pickup_time"];
    this.restaurantAbout = json["restaurant_about"];
    this.username = json["username"];
    this.estimateTime = json["estimate_time"];
    this.minimumOrder = json["minimum_order"];
    this.freeDelivery = json["free_delivery"];
    this.rewardOption = json["reward_option"];
    this.status = json["status"];
    this.deleteStatus = json["delete_status"];
    this.created = json["created"];
    this.modified = json["modified"];
    // this.offers = json["offers"] == null
    //     ? null
    //     : (json["offers"] as List).map((e) => Offers.fromJson(e)).toList();
    this.toDistance = json["to_distance"];
    this.deliveryCharge = json["delivery_charge"].toString();
    // this.restOffers = json["restOffers"] == null
    //     ? null
    //     : (json["restOffers"] as List)
    //         .map((e) => RestOffers.fromJson(e))
    //         .toList();
    this.totalRating = json["totalRating"];
    this.finalReview = double.parse(json["finalReview"].toString());
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

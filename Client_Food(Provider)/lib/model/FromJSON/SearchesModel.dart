class SearchesModel {
  String? status;
  Result? result;

  SearchesModel({this.status, this.result});

  SearchesModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  List<RestaurantLists>? restaurantLists;
  List<AllCuisinesLists>? allCuisinesLists;
  List<BannerLists>? bannerLists;
  SiteSettings? siteSettings;
  String? firstUser;
  int? success;

  Result(
      {this.restaurantLists,
      this.allCuisinesLists,
      this.bannerLists,
      this.siteSettings,
      this.firstUser,
      this.success});

  Result.fromJson(Map<String, dynamic> json) {
    this.restaurantLists = json["restaurantLists"] == null
        ? null
        : (json["restaurantLists"] as List)
            .map((e) => RestaurantLists.fromJson(e))
            .toList();
    this.allCuisinesLists = json["allCuisinesLists"] == null
        ? null
        : (json["allCuisinesLists"] as List)
            .map((e) => AllCuisinesLists.fromJson(e))
            .toList();
    this.bannerLists = json["bannerLists"] == null
        ? null
        : (json["bannerLists"] as List)
            .map((e) => BannerLists.fromJson(e))
            .toList();
    this.siteSettings = json["siteSettings"] == null
        ? null
        : SiteSettings.fromJson(json["siteSettings"]);
    this.firstUser = json["firstUser"];
    this.success = json["success"];
  }
}

class SiteSettings {
  int? id;
  int? userId;
  String? siteName;
  String? siteLogo;
  String? siteFav;
  String? addressMode;
  String? searchBy;
  String? adminName;
  String? adminEmail;
  String? contactUsEmail;
  String? orderEmail;
  String? invoiceEmail;
  String? contactPhone;
  String? siteAddress;
  String? siteCountry;
  String? siteState;
  String? siteCity;
  String? siteZip;
  String? siteCurrency;
  String? siteTimezone;
  String? stripeMode;
  String? stripeSecretkey;
  String? stripePublishkey;
  String? stripeSecretkeyTest;
  String? stripePublishkeyTest;
  String? omiseMode;
  String? omiseLiveSecretkey;
  String? omiseLivePublickey;
  String? omiseTestSecretkey;
  String? omiseTestPublickey;
  String? paypalMode;
  String? testClientid;
  String? liveClientid;
  String? paypalTestUrl;
  String? paypalLiveUrl;
  String? businessTestAccount;
  String? businessLiveAccount;
  String? googleAnalytics;
  String? woopraAnalytics;
  dynamic zoopimCode;
  String? mailOption;
  String? smtpHost;
  String? smtpPort;
  String? smtpUsername;
  String? smtpPassword;
  String? vatNo;
  int? vatPercent;
  int? cardFee;
  String? invoiceDuration;
  String? offlineStatus;
  String? offlineNotes;
  String? smsOption;
  String? smsToken;
  String? smsId;
  String? smsSourceNumber;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  String? multipleLanguage;
  String? defaultLanguage;
  String? otherLanguage;
  String? facebookApiId;
  String? facebookSecretKey;
  String? googleApiId;
  String? googleSecretKey;
  String? googleKey1;
  String? mailchimpKey;
  String? mailchimpListId;
  String? pusherKey;
  String? pusherSecret;
  String? pusherId;
  String? assignStatus;
  int? assignMiles;
  String? fcmKey;
  String? cloudName;
  String? cloudApiKey;
  String? cloudApiSecret;
  String? teliverKey;
  String? foloosiMode;
  String? foloosiDomain;
  String? created;
  dynamic updated;
  dynamic createdBy;
  int? modifiedBy;
  String? dispatchOption;

  SiteSettings(
      {this.id,
      this.userId,
      this.siteName,
      this.siteLogo,
      this.siteFav,
      this.addressMode,
      this.searchBy,
      this.adminName,
      this.adminEmail,
      this.contactUsEmail,
      this.orderEmail,
      this.invoiceEmail,
      this.contactPhone,
      this.siteAddress,
      this.siteCountry,
      this.siteState,
      this.siteCity,
      this.siteZip,
      this.siteCurrency,
      this.siteTimezone,
      this.stripeMode,
      this.stripeSecretkey,
      this.stripePublishkey,
      this.stripeSecretkeyTest,
      this.stripePublishkeyTest,
      this.omiseMode,
      this.omiseLiveSecretkey,
      this.omiseLivePublickey,
      this.omiseTestSecretkey,
      this.omiseTestPublickey,
      this.paypalMode,
      this.testClientid,
      this.liveClientid,
      this.paypalTestUrl,
      this.paypalLiveUrl,
      this.businessTestAccount,
      this.businessLiveAccount,
      this.googleAnalytics,
      this.woopraAnalytics,
      this.zoopimCode,
      this.mailOption,
      this.smtpHost,
      this.smtpPort,
      this.smtpUsername,
      this.smtpPassword,
      this.vatNo,
      this.vatPercent,
      this.cardFee,
      this.invoiceDuration,
      this.offlineStatus,
      this.offlineNotes,
      this.smsOption,
      this.smsToken,
      this.smsId,
      this.smsSourceNumber,
      this.metaTitle,
      this.metaKeywords,
      this.metaDescription,
      this.multipleLanguage,
      this.defaultLanguage,
      this.otherLanguage,
      this.facebookApiId,
      this.facebookSecretKey,
      this.googleApiId,
      this.googleSecretKey,
      this.googleKey1,
      this.mailchimpKey,
      this.mailchimpListId,
      this.pusherKey,
      this.pusherSecret,
      this.pusherId,
      this.assignStatus,
      this.assignMiles,
      this.fcmKey,
      this.cloudName,
      this.cloudApiKey,
      this.cloudApiSecret,
      this.teliverKey,
      this.foloosiMode,
      this.foloosiDomain,
      this.created,
      this.updated,
      this.createdBy,
      this.modifiedBy,
      this.dispatchOption});

  SiteSettings.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userId = json["user_id"];
    this.siteName = json["site_name"];
    this.siteLogo = json["site_logo"];
    this.siteFav = json["site_fav"];
    this.addressMode = json["address_mode"];
    this.searchBy = json["search_by"];
    this.adminName = json["admin_name"];
    this.adminEmail = json["admin_email"];
    this.contactUsEmail = json["contact_us_email"];
    this.orderEmail = json["order_email"];
    this.invoiceEmail = json["invoice_email"];
    this.contactPhone = json["contact_phone"];
    this.siteAddress = json["site_address"];
    this.siteCountry = json["site_country"];
    this.siteState = json["site_state"];
    this.siteCity = json["site_city"];
    this.siteZip = json["site_zip"];
    this.siteCurrency = json["site_currency"];
    this.siteTimezone = json["site_timezone"];
    this.stripeMode = json["stripe_mode"];
    this.stripeSecretkey = json["stripe_secretkey"];
    this.stripePublishkey = json["stripe_publishkey"];
    this.stripeSecretkeyTest = json["stripe_secretkeyTest"];
    this.stripePublishkeyTest = json["stripe_publishkeyTest"];
    this.omiseMode = json["omise_mode"];
    this.omiseLiveSecretkey = json["omise_live_secretkey"];
    this.omiseLivePublickey = json["omise_live_publickey"];
    this.omiseTestSecretkey = json["omise_test_secretkey"];
    this.omiseTestPublickey = json["omise_test_publickey"];
    this.paypalMode = json["paypal_mode"];
    this.testClientid = json["test_clientid"];
    this.liveClientid = json["live_clientid"];
    this.paypalTestUrl = json["paypal_test_url"];
    this.paypalLiveUrl = json["paypal_live_url"];
    this.businessTestAccount = json["business_test_account"];
    this.businessLiveAccount = json["business_live_account"];
    this.googleAnalytics = json["google_analytics"];
    this.woopraAnalytics = json["woopra_analytics"];
    this.zoopimCode = json["zoopim_code"];
    this.mailOption = json["mail_option"];
    this.smtpHost = json["smtp_host"];
    this.smtpPort = json["smtp_port"];
    this.smtpUsername = json["smtp_username"];
    this.smtpPassword = json["smtp_password"];
    this.vatNo = json["vat_no"];
    this.vatPercent = json["vat_percent"];
    this.cardFee = json["card_fee"];
    this.invoiceDuration = json["invoice_duration"];
    this.offlineStatus = json["offline_status"];
    this.offlineNotes = json["offline_notes"];
    this.smsOption = json["sms_option"];
    this.smsToken = json["sms_token"];
    this.smsId = json["sms_id"];
    this.smsSourceNumber = json["sms_source_number"];
    this.metaTitle = json["meta_title"];
    this.metaKeywords = json["meta_keywords"];
    this.metaDescription = json["meta_description"];
    this.multipleLanguage = json["multiple_language"];
    this.defaultLanguage = json["default_language"];
    this.otherLanguage = json["other_language"];
    this.facebookApiId = json["facebook_api_id"];
    this.facebookSecretKey = json["facebook_secret_key"];
    this.googleApiId = json["google_api_id"];
    this.googleSecretKey = json["google_secret_key"];
    this.googleKey1 = json["google_key1"];
    this.mailchimpKey = json["mailchimp_key"];
    this.mailchimpListId = json["mailchimp_list_id"];
    this.pusherKey = json["pusher_key"];
    this.pusherSecret = json["pusher_secret"];
    this.pusherId = json["pusher_id"];
    this.assignStatus = json["assign_status"];
    this.assignMiles = json["assign_miles"];
    this.fcmKey = json["fcm_key"];
    this.cloudName = json["cloud_name"];
    this.cloudApiKey = json["cloud_api_key"];
    this.cloudApiSecret = json["cloud_api_secret"];
    this.teliverKey = json["teliver_key"];
    this.foloosiMode = json["foloosi_mode"];
    this.foloosiDomain = json["foloosi_domain"];
    this.created = json["created"];
    this.updated = json["updated"];
    this.createdBy = json["created_by"];
    this.modifiedBy = json["modified_by"];
    this.dispatchOption = json["dispatch_option"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["site_name"] = this.siteName;
    data["site_logo"] = this.siteLogo;
    data["site_fav"] = this.siteFav;
    data["address_mode"] = this.addressMode;
    data["search_by"] = this.searchBy;
    data["admin_name"] = this.adminName;
    data["admin_email"] = this.adminEmail;
    data["contact_us_email"] = this.contactUsEmail;
    data["order_email"] = this.orderEmail;
    data["invoice_email"] = this.invoiceEmail;
    data["contact_phone"] = this.contactPhone;
    data["site_address"] = this.siteAddress;
    data["site_country"] = this.siteCountry;
    data["site_state"] = this.siteState;
    data["site_city"] = this.siteCity;
    data["site_zip"] = this.siteZip;
    data["site_currency"] = this.siteCurrency;
    data["site_timezone"] = this.siteTimezone;
    data["stripe_mode"] = this.stripeMode;
    data["stripe_secretkey"] = this.stripeSecretkey;
    data["stripe_publishkey"] = this.stripePublishkey;
    data["stripe_secretkeyTest"] = this.stripeSecretkeyTest;
    data["stripe_publishkeyTest"] = this.stripePublishkeyTest;
    data["omise_mode"] = this.omiseMode;
    data["omise_live_secretkey"] = this.omiseLiveSecretkey;
    data["omise_live_publickey"] = this.omiseLivePublickey;
    data["omise_test_secretkey"] = this.omiseTestSecretkey;
    data["omise_test_publickey"] = this.omiseTestPublickey;
    data["paypal_mode"] = this.paypalMode;
    data["test_clientid"] = this.testClientid;
    data["live_clientid"] = this.liveClientid;
    data["paypal_test_url"] = this.paypalTestUrl;
    data["paypal_live_url"] = this.paypalLiveUrl;
    data["business_test_account"] = this.businessTestAccount;
    data["business_live_account"] = this.businessLiveAccount;
    data["google_analytics"] = this.googleAnalytics;
    data["woopra_analytics"] = this.woopraAnalytics;
    data["zoopim_code"] = this.zoopimCode;
    data["mail_option"] = this.mailOption;
    data["smtp_host"] = this.smtpHost;
    data["smtp_port"] = this.smtpPort;
    data["smtp_username"] = this.smtpUsername;
    data["smtp_password"] = this.smtpPassword;
    data["vat_no"] = this.vatNo;
    data["vat_percent"] = this.vatPercent;
    data["card_fee"] = this.cardFee;
    data["invoice_duration"] = this.invoiceDuration;
    data["offline_status"] = this.offlineStatus;
    data["offline_notes"] = this.offlineNotes;
    data["sms_option"] = this.smsOption;
    data["sms_token"] = this.smsToken;
    data["sms_id"] = this.smsId;
    data["sms_source_number"] = this.smsSourceNumber;
    data["meta_title"] = this.metaTitle;
    data["meta_keywords"] = this.metaKeywords;
    data["meta_description"] = this.metaDescription;
    data["multiple_language"] = this.multipleLanguage;
    data["default_language"] = this.defaultLanguage;
    data["other_language"] = this.otherLanguage;
    data["facebook_api_id"] = this.facebookApiId;
    data["facebook_secret_key"] = this.facebookSecretKey;
    data["google_api_id"] = this.googleApiId;
    data["google_secret_key"] = this.googleSecretKey;
    data["google_key1"] = this.googleKey1;
    data["mailchimp_key"] = this.mailchimpKey;
    data["mailchimp_list_id"] = this.mailchimpListId;
    data["pusher_key"] = this.pusherKey;
    data["pusher_secret"] = this.pusherSecret;
    data["pusher_id"] = this.pusherId;
    data["assign_status"] = this.assignStatus;
    data["assign_miles"] = this.assignMiles;
    data["fcm_key"] = this.fcmKey;
    data["cloud_name"] = this.cloudName;
    data["cloud_api_key"] = this.cloudApiKey;
    data["cloud_api_secret"] = this.cloudApiSecret;
    data["teliver_key"] = this.teliverKey;
    data["foloosi_mode"] = this.foloosiMode;
    data["foloosi_domain"] = this.foloosiDomain;
    data["created"] = this.created;
    data["updated"] = this.updated;
    data["created_by"] = this.createdBy;
    data["modified_by"] = this.modifiedBy;
    data["dispatch_option"] = this.dispatchOption;
    return data;
  }
}

class BannerLists {
  String? bannerImage;
  BannerLists({this.bannerImage});

  BannerLists.fromJson(Map<String, dynamic> json) {
    this.bannerImage = json["banner_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["banner_image"] = this.bannerImage;
    return data;
  }
}

class AllCuisinesLists {
  int? id;
  String? name;
  String? urlImg;
  String? iconImg;
  String? colorImg;

  AllCuisinesLists(
      {this.id, this.name, this.urlImg, this.iconImg, this.colorImg});

  AllCuisinesLists.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.urlImg = json["url_img"];
    this.iconImg = json["icon_img"];
    this.colorImg = json["color_img"];
  }
}

class RestaurantLists {
  String? id;
  String? restaurantName;
  String? restaurantLogo;
  String? favourite;
  String? promotionTitle;
  String? currentStatus;
  String? cuisineLists;
  List<String> listCuisine = [];

  RestaurantLists(
      {this.id,
      this.restaurantName,
      this.restaurantLogo,
      this.favourite,
      this.promotionTitle,
      this.currentStatus,
      this.cuisineLists});

  RestaurantLists.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.restaurantName = json["restaurant_name"];
    this.restaurantLogo = json["restaurant_logo"];
    this.favourite = json["favourite"].toString();
    this.promotionTitle = json["promotion_title"];
    this.currentStatus = json["currentStatus"];
    this.cuisineLists = json["cuisineLists"];
  }
}

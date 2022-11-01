class CustomerDetailsModel {
  String? status;
  Result? result;

  CustomerDetailsModel({this.status, this.result});

  CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? success;
  int? customerId;
  String? firstName;
  String? lastName;
  String? email;
  String? customerPhone;
  String? sex;
  String? birthday;
  CustomerDetails? customerDetails;

  Result(
      {this.success,
      this.customerId,
      this.firstName,
      this.lastName,
      this.email,
      this.customerPhone,
      this.sex,
      this.birthday,
      this.customerDetails});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"].toString();
    this.customerId = json["customerId"];
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.email = json["email"];
    this.customerPhone = json["customerPhone"];
    this.sex = json["sex"];
    this.birthday = json["birthday"] == null ? '' : json['birthday'];
    this.customerDetails = json["customerDetails"] == null
        ? null
        : CustomerDetails.fromJson(json["customerDetails"]);
  }
}

class CustomerDetails {
  int? id;
  int? roleId;
  String? username;
  String? password;
  String? permissions;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? userType;
  String? referralCode;
  String? referredBy;
  String? rewardExpiryDate;
  String? walletAmount;
  String? image;
  String? newsletter;
  String? signupFrom;
  String? signupDevice;
  String? deviceType;
  String? deviceId;
  dynamic rpayToken;
  String? status;
  String? deletedStatus;
  String? created;
  String? modified;
  String? dateOfBirth;

  CustomerDetails(
      {this.id,
      this.roleId,
      this.username,
      this.password,
      this.permissions,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.userType,
      this.referralCode,
      this.referredBy,
      this.rewardExpiryDate,
      this.walletAmount,
      this.image,
      this.newsletter,
      this.signupFrom,
      this.signupDevice,
      this.deviceType,
      this.deviceId,
      this.rpayToken,
      this.status,
      this.deletedStatus,
      this.created,
      this.modified,
      this.dateOfBirth});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.roleId = json["role_id"];
    this.username = json["username"];
    this.password = json["password"];
    this.permissions = json["permissions"];
    this.firstName = json["first_name"];
    this.lastName = json["last_name"];
    this.phoneNumber = json["phone_number"];
    this.address = json["address"];
    this.userType = json["user_type"];
    this.referralCode = json["referral_code"];
    this.referredBy = json["referred_by"];
    this.rewardExpiryDate = json["reward_expiry_date"];
    this.walletAmount = json["wallet_amount"].toString();
    this.image = json["image"];
    this.newsletter = json["newsletter"];
    this.signupFrom = json["signup_from"];
    this.signupDevice = json["signup_device"];
    this.deviceType = json["device_type"];
    this.deviceId = json["device_id"];
    this.rpayToken = json["rpay_token"];
    this.status = json["status"];
    this.deletedStatus = json["deleted_status"];
    this.created = json["created"];
    this.modified = json["modified"];
    this.dateOfBirth = json["date_of_birth"];
  }
}

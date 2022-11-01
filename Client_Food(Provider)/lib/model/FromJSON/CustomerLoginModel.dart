class CustomerLoginModel {
  String? status;
  Result? result;

  CustomerLoginModel({this.status, this.result});

  CustomerLoginModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? firstUser;
  int? success;
  String? message;
  int? customerId;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? referralCode;
  String? customerPhone;
  int? custDeviceId;
  String? otp;

  Result(
      {this.firstUser,
      this.success,
      this.message,
      this.customerId,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.referralCode,
      this.customerPhone,
      this.custDeviceId,
      this.otp});

  Result.fromJson(Map<String, dynamic> json) {
    this.firstUser = json["first_user"];
    this.success = json["success"];
    this.message = json["message"];
    this.customerId = json["customerId"];
    this.name = json["name"];
    this.firstName = json["firstName"];
    this.lastName = json["lastName"];
    this.email = json["email"];
    this.referralCode = json["referral_code"];
    this.customerPhone = json["customerPhone"];
    this.custDeviceId = json["custDeviceId"];
    this.otp = json["otp"];
  }
}

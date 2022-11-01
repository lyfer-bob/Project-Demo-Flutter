class CustomerSignUpModel {
  String? username;
  String? firstName;
  String? lastName;
  String? password;
  String? phoneNumber;
  String? referralCode;
  String? sex;
  String? birthday;

  CustomerSignUpModel(
      {this.username,
      this.firstName,
      this.lastName,
      this.password,
      this.phoneNumber,
      this.referralCode,
      this.sex,
      this.birthday});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] = this.username;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["password"] = this.password;
    data["phone_number"] = this.phoneNumber;
    data["referral_code"] = this.referralCode;
    data["gender"] = this.sex;
    data["birthday"] = this.birthday;
    return data;
  }
}

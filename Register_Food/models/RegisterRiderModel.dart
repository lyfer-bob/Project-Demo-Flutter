class RegisterRiderModel {
  String? registerId;
  String? action;
  String? registerChannel;
  String? transId;
  Profile? profile;
  Area? area;

  RegisterRiderModel(
      {this.registerId,
      this.action,
      this.registerChannel,
      this.transId,
      this.profile,
      this.area});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["register_id"] = this.registerId;
    data["action"] = this.action;
    data["register_channel"] = this.registerChannel;
    data["trans_id"] = this.transId;
    if (this.profile != null) data["profile"] = this.profile!.toJson();
    if (this.area != null) data["area"] = this.area!.toJson();
    return data;
  }
}

class Area {
  String? provinceId;
  Area({this.provinceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["province_id"] = this.provinceId;
    return data;
  }
}

class Profile {
  String? email;
  String? imgRider;
  String? titleName;
  String? firstName;
  String? lastName;
  String? iDcard;
  String? gender;
  String? birthday;
  String? age;
  String? phone;
  int? riderBill;
  String? home;
  String? building;
  int? tumbol;
  int? amphur;
  int? province;
  String? zipcode;
  String? cardHome;
  String? cardBuilding;
  int? cardTumbol;
  int? cardAmphur;
  int? cardProvince;
  String? cardZipcode;
  int? bank;
  String? bankNumber;
  String? bankName;
  String? bookbank;
  String? carBrand;
  String? carModel;
  String? carNumber;
  int? carProvince;
  String? fileIdentity;
  String? fileCar;
  String? fileHome;
  String? fileDriverLicense;
  String? fileAcceptOwnerCare;
  String? fileOwnerIdentity;
  String? ownerCar;
  String? idcardActivateDate;
  String? idcardExpiredDate;
  String? packageTool;
  String? acceptList;
  String? termsConditionsNews;
  String? acceptNews;
  String? additionalIncome;
  String? contactFName;
  String? contactLName;
  String? contactPhone;
  String? contactRelationship;

  Profile(
      {this.email,
      this.imgRider,
      this.titleName,
      this.firstName,
      this.lastName,
      this.iDcard,
      this.gender,
      this.birthday,
      this.age,
      this.phone,
      this.riderBill,
      this.home,
      this.building,
      this.tumbol,
      this.amphur,
      this.province,
      this.zipcode,
      this.cardHome,
      this.cardBuilding,
      this.cardTumbol,
      this.cardAmphur,
      this.cardProvince,
      this.cardZipcode,
      this.bank,
      this.bankNumber,
      this.bankName,
      this.bookbank,
      this.carBrand,
      this.carModel,
      this.carNumber,
      this.carProvince,
      this.fileIdentity,
      this.fileCar,
      this.fileHome,
      this.fileDriverLicense,
      this.fileAcceptOwnerCare,
      this.fileOwnerIdentity,
      this.ownerCar,
      this.idcardActivateDate,
      this.idcardExpiredDate,
      this.packageTool,
      this.acceptList,
      this.termsConditionsNews,
      this.acceptNews,
      this.additionalIncome,
      this.contactFName,
      this.contactLName,
      this.contactPhone,
      this.contactRelationship});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["email"] = this.email;

    data["img_rider"] = this.imgRider;

    data["title_name"] = this.titleName;
    data["first_name"] = this.firstName;
    data["last_name"] = this.lastName;
    data["IDcard"] = this.iDcard;
    data["gender"] = this.gender;
    data["birthday"] = this.birthday;
    data["Age"] = this.age;
    data["phone"] = this.phone;
    data["rider_bill"] = this.riderBill;
    data["home"] = this.home;
    data["building"] = this.building;
    data["tumbol"] = this.tumbol;
    data["amphur"] = this.amphur;
    data["province"] = this.province;
    data["zipcode"] = this.zipcode;

    data["card_home"] = this.cardHome;
    data["card_building"] = this.cardBuilding;
    data["card_tumbol"] = this.cardTumbol;
    data["card_amphur"] = this.cardAmphur;
    data["card_province"] = this.cardProvince;
    data["card_zipcode"] = this.cardZipcode;
    data["bank"] = this.bank;
    data["bank_number"] = this.bankNumber;
    data["bank_name"] = this.bankName;

    data["Bookbank"] = this.bookbank;

    data["car_brand"] = this.carBrand;
    data["car_model"] = this.carModel;
    data["car_number"] = this.carNumber;
    data["car_province"] = this.carProvince;

    data["file_Identity"] = this.fileIdentity;
    data["file_car"] = this.fileCar;
    data["file_home"] = this.fileHome;
    data["file_driverLicense"] = this.fileDriverLicense;
    data["file_acceptOwnerCare"] = this.fileAcceptOwnerCare;
    data["file_OwnerIdentity"] = this.fileOwnerIdentity;

    data["owner_car"] = this.ownerCar;
    data["Idcard_activateDate"] = this.idcardActivateDate;
    data["Idcard_expiredDate"] = this.idcardExpiredDate;
    data["package_tool"] = this.packageTool;
    data["acceptList"] = this.acceptList;
    data["terms_conditionsNews"] = this.termsConditionsNews;
    data["accept_news"] = this.acceptNews;
    data["additionalIncome"] = this.additionalIncome;
    data["contact_FName"] = this.contactFName;
    data["contact_LName"] = this.contactLName;
    data["contact_phone"] = this.contactPhone;
    data["contact_relationship"] = this.contactRelationship;
    return data;
  }
}

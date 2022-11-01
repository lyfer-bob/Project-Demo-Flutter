class AddressBookListModel {
  String? status;
  Result? result;

  AddressBookListModel({this.status, this.result});

  AddressBookListModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  List<AddressBook>? addressBook;

  Result({this.success, this.addressBook});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.addressBook = json["addressBook"] == null
        ? null
        : (json["addressBook"] as List)
            .map((e) => AddressBook.fromJson(e))
            .toList();
  }
}

class AddressBook {
  int? id;
  int? userId;
  String? title;
  String? flatNo;
  String? address;
  String? latitude;
  String? longitude;
  String? landmark;
  int? stateId;
  int? cityId;
  int? locationId;
  String? addressPhone;
  String? status;
  String? deleteStatus;
  String? created;
  String? modified;

  AddressBook(
      {this.id,
      this.userId,
      this.title,
      this.flatNo,
      this.address,
      this.latitude,
      this.longitude,
      this.landmark,
      this.stateId,
      this.cityId,
      this.locationId,
      this.addressPhone,
      this.status,
      this.deleteStatus,
      this.created,
      this.modified});

  AddressBook.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userId = json["user_id"];
    this.title = json["title"];
    this.flatNo = json["flat_no"];
    this.address = json["address"];
    this.latitude = json["latitude"];
    this.longitude = json["longitude"];
    this.landmark = json["landmark"];
    this.stateId = json["state_id"];
    this.cityId = json["city_id"];
    this.locationId = json["location_id"];
    this.addressPhone = json["address_phone"];
    this.status = json["status"];
    this.deleteStatus = json["delete_status"];
    this.created = json["created"];
    this.modified = json["modified"];
  }
}

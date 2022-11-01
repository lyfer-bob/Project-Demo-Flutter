class CountryModel {
  List<Country>? country;

  CountryModel({this.country});

  CountryModel.fromJson(Map<String, dynamic> json) {
    this.country = json["country"] == null
        ? null
        : (json["country"] as List).map((e) => Country.fromJson(e)).toList();
  }
}

class Country {
  int? id;
  String? nameTh;
  String? nameEn;
  int? geographyId;
  String? selectStatus;

  Country(
      {this.id, this.nameTh, this.nameEn, this.geographyId, this.selectStatus});

  Country.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.nameTh = json["name_th"];
    this.nameEn = json["name_en"];
    this.geographyId = json["geography_id"];
    this.selectStatus = json["select_status"];
  }
}

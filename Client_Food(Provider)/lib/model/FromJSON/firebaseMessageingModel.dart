class FirebaseMessageDataModel {
  String? orderid;
  String? ordernumber;
  String? notitype;

  FirebaseMessageDataModel({
    this.orderid,
    this.ordernumber,
    this.notitype,
  });

  FirebaseMessageDataModel.fromJson(Map<String, dynamic> json) {
    this.orderid = json["orderid"];
    this.ordernumber = json["ordernumber"];
    this.notitype = json["notitype"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["orderid"] = this.orderid;
    data["ordernumber"] = this.ordernumber;
    data["notitype"] = this.notitype;
    return data;
  }
}

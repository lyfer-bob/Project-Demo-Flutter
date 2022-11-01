class CreditCardListModel {
  String? status;
  Result? result;

  CreditCardListModel({this.status, this.result});

  CreditCardListModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  String? success;
  List<CardDetails>? cardDetails;

  Result({this.success, this.cardDetails});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"].toString();
    this.cardDetails = json["cardDetails"] == null
        ? null
        : (json["cardDetails"] as List)
            .map((e) => CardDetails.fromJson(e))
            .toList();
  }
}

class CardDetails {
  int? id;
  int? customerId;
  String? customerName;
  String? omiseTokenId;
  String? omiseCustomerId;
  String? cardId;
  String? cardNumber;
  String? cardBrand;
  String? cardType;
  int? expMonth;
  int? expYear;
  String? country;
  String? clientIp;
  bool? status;
  String? created;
  String? modified;
  bool? statusSelect;

  CardDetails(
      {this.id,
      this.customerId,
      this.customerName,
      this.omiseTokenId,
      this.omiseCustomerId,
      this.cardId,
      this.cardNumber,
      this.cardBrand,
      this.cardType,
      this.expMonth,
      this.expYear,
      this.country,
      this.clientIp,
      this.status,
      this.created,
      this.modified,
      this.statusSelect});

  CardDetails.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.customerId = json["customer_id"];
    this.customerName = json["customer_name"];
    this.omiseTokenId = json["omise_token_id"];
    this.omiseCustomerId = json["omise_customer_id"];
    this.cardId = json["card_id"];
    this.cardNumber = json["card_number"];
    this.cardBrand = json["card_brand"];
    this.cardType = json["card_type"];
    this.expMonth = json["exp_month"];
    this.expYear = json["exp_year"];
    this.country = json["country"];
    this.clientIp = json["client_ip"];
    this.status = json["status"];
    this.created = json["created"];
    this.modified = json["modified"];
  }
}

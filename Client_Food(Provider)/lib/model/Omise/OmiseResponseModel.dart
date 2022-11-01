class OmiseResponseModel {
  String? status;
  Result? result;

  OmiseResponseModel({this.status, this.result});

  OmiseResponseModel.fromJson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.result =
        json["result"] == null ? null : Result.fromJson(json["result"]);
  }
}

class Result {
  int? success;
  String? message;
  Charges? charges;

  Result({this.success, this.message, this.charges});

  Result.fromJson(Map<String, dynamic> json) {
    this.success = json["success"];
    this.message = json["message"];
    this.charges =
        json["charges"] == null ? null : Charges.fromJson(json["charges"]);
  }
}

class Charges {
  String? object;
  String? id;
  String? location;
  int? amount;
  int? net;
  int? fee;
  int? feeVat;
  int? interest;
  int? interestVat;
  int? fundingAmount;
  int? refundedAmount;
  TransactionFees? transactionFees;
  PlatformFee? platformFee;
  String? currency;
  String? fundingCurrency;
  dynamic ip;
  Refunds? refunds;
  dynamic link;
  dynamic description;
  List<dynamic>? metadata;
  dynamic card;
  Source? source;
  dynamic schedule;
  dynamic customer;
  dynamic dispute;
  dynamic transaction;
  dynamic failureCode;
  dynamic failureMessage;
  String? status;
  String? authorizeUri;
  dynamic returnUri;
  String? createdAt;
  dynamic paidAt;
  String? expiresAt;
  dynamic expiredAt;
  dynamic reversedAt;
  bool? zeroInterestInstallments;
  dynamic branch;
  dynamic terminal;
  dynamic device;
  bool? authorized;
  bool? capturable;
  bool? capture;
  bool? disputable;
  bool? livemode;
  bool? refundable;
  bool? reversed;
  bool? reversible;
  bool? voided;
  bool? paid;
  bool? expired;

  Charges(
      {this.object,
      this.id,
      this.location,
      this.amount,
      this.net,
      this.fee,
      this.feeVat,
      this.interest,
      this.interestVat,
      this.fundingAmount,
      this.refundedAmount,
      this.transactionFees,
      this.platformFee,
      this.currency,
      this.fundingCurrency,
      this.ip,
      this.refunds,
      this.link,
      this.description,
      this.metadata,
      this.card,
      this.source,
      this.schedule,
      this.customer,
      this.dispute,
      this.transaction,
      this.failureCode,
      this.failureMessage,
      this.status,
      this.authorizeUri,
      this.returnUri,
      this.createdAt,
      this.paidAt,
      this.expiresAt,
      this.expiredAt,
      this.reversedAt,
      this.zeroInterestInstallments,
      this.branch,
      this.terminal,
      this.device,
      this.authorized,
      this.capturable,
      this.capture,
      this.disputable,
      this.livemode,
      this.refundable,
      this.reversed,
      this.reversible,
      this.voided,
      this.paid,
      this.expired});

  Charges.fromJson(Map<String, dynamic> json) {
    this.object = json["object"];
    this.id = json["id"];
    this.location = json["location"];
    this.amount = json["amount"];
    this.net = json["net"];
    this.fee = json["fee"];
    this.feeVat = json["fee_vat"];
    this.interest = json["interest"];
    this.interestVat = json["interest_vat"];
    this.fundingAmount = json["funding_amount"];
    this.refundedAmount = json["refunded_amount"];
    this.transactionFees = json["transaction_fees"] == null
        ? null
        : TransactionFees.fromJson(json["transaction_fees"]);
    this.platformFee = json["platform_fee"] == null
        ? null
        : PlatformFee.fromJson(json["platform_fee"]);
    this.currency = json["currency"];
    this.fundingCurrency = json["funding_currency"];
    this.ip = json["ip"];
    this.refunds =
        json["refunds"] == null ? null : Refunds.fromJson(json["refunds"]);
    this.link = json["link"];
    this.description = json["description"];
    this.metadata = json["metadata"] ?? [];
    this.card = json["card"];
    this.source =
        json["source"] == null ? null : Source.fromJson(json["source"]);
    this.schedule = json["schedule"];
    this.customer = json["customer"];
    this.dispute = json["dispute"];
    this.transaction = json["transaction"];
    this.failureCode = json["failure_code"];
    this.failureMessage = json["failure_message"];
    this.status = json["status"];
    this.authorizeUri =
        json["authorize_uri"] == null ? '' : json["authorize_uri"];
    this.returnUri = json["return_uri"];
    this.createdAt = json["created_at"];
    this.paidAt = json["paid_at"];
    this.expiresAt = json["expires_at"];
    this.expiredAt = json["expired_at"];
    this.reversedAt = json["reversed_at"];
    this.zeroInterestInstallments = json["zero_interest_installments"];
    this.branch = json["branch"];
    this.terminal = json["terminal"];
    this.device = json["device"];
    this.authorized = json["authorized"];
    this.capturable = json["capturable"];
    this.capture = json["capture"];
    this.disputable = json["disputable"];
    this.livemode = json["livemode"];
    this.refundable = json["refundable"];
    this.reversed = json["reversed"];
    this.reversible = json["reversible"];
    this.voided = json["voided"];
    this.paid = json["paid"];
    this.expired = json["expired"];
  }
}

class Source {
  String? object;
  String? id;
  bool? livemode;
  String? location;
  int? amount;
  dynamic barcode;
  dynamic bank;
  String? createdAt;
  String? currency;
  dynamic email;
  String? flow;
  dynamic installmentTerm;
  dynamic absorptionType;
  dynamic name;
  dynamic mobileNumber;
  dynamic phoneNumber;
  dynamic platformType;
  ScannableCode? scannableCode;
  dynamic references;
  dynamic storeId;
  dynamic storeName;
  dynamic terminalId;
  String? type;
  dynamic zeroInterestInstallments;
  String? chargeStatus;
  dynamic receiptAmount;
  List<dynamic>? discounts;

  Source(
      {this.object,
      this.id,
      this.livemode,
      this.location,
      this.amount,
      this.barcode,
      this.bank,
      this.createdAt,
      this.currency,
      this.email,
      this.flow,
      this.installmentTerm,
      this.absorptionType,
      this.name,
      this.mobileNumber,
      this.phoneNumber,
      this.platformType,
      this.scannableCode,
      this.references,
      this.storeId,
      this.storeName,
      this.terminalId,
      this.type,
      this.zeroInterestInstallments,
      this.chargeStatus,
      this.receiptAmount,
      this.discounts});

  Source.fromJson(Map<String, dynamic> json) {
    this.object = json["object"];
    this.id = json["id"];
    this.livemode = json["livemode"];
    this.location = json["location"];
    this.amount = json["amount"];
    this.barcode = json["barcode"];
    this.bank = json["bank"];
    this.createdAt = json["created_at"];
    this.currency = json["currency"];
    this.email = json["email"];
    this.flow = json["flow"];
    this.installmentTerm = json["installment_term"];
    this.absorptionType = json["absorption_type"];
    this.name = json["name"];
    this.mobileNumber = json["mobile_number"];
    this.phoneNumber = json["phone_number"];
    this.platformType = json["platform_type"];
    this.scannableCode = json["scannable_code"] == null
        ? null
        : ScannableCode.fromJson(json["scannable_code"]);
    this.references = json["references"];
    this.storeId = json["store_id"];
    this.storeName = json["store_name"];
    this.terminalId = json["terminal_id"];
    this.type = json["type"];
    this.zeroInterestInstallments = json["zero_interest_installments"];
    this.chargeStatus = json["charge_status"];
    this.receiptAmount = json["receipt_amount"];
    this.discounts = json["discounts"] ?? [];
  }
}

class ScannableCode {
  String? object;
  String? type;
  Image? image;

  ScannableCode({this.object, this.type, this.image});

  ScannableCode.fromJson(Map<String, dynamic> json) {
    this.object = json["object"];
    this.type = json["type"];
    this.image = json["image"] == null ? null : Image.fromJson(json["image"]);
  }
}

class Image {
  String? object;
  bool? livemode;
  String? id;
  bool? deleted;
  String? filename;
  String? location;
  String? kind;
  String? downloadUri;
  String? createdAt;

  Image(
      {this.object,
      this.livemode,
      this.id,
      this.deleted,
      this.filename,
      this.location,
      this.kind,
      this.downloadUri,
      this.createdAt});

  Image.fromJson(Map<String, dynamic> json) {
    this.object = json["object"];
    this.livemode = json["livemode"];
    this.id = json["id"];
    this.deleted = json["deleted"];
    this.filename = json["filename"];
    this.location = json["location"];
    this.kind = json["kind"];
    this.downloadUri = json["download_uri"];
    this.createdAt = json["created_at"];
  }
}

class Refunds {
  String? object;
  List<dynamic>? data;
  int? limit;
  int? offset;
  int? total;
  String? location;
  String? order;
  String? from;
  String? to;

  Refunds(
      {this.object,
      this.data,
      this.limit,
      this.offset,
      this.total,
      this.location,
      this.order,
      this.from,
      this.to});

  Refunds.fromJson(Map<String, dynamic> json) {
    this.object = json["object"];
    this.data = json["data"] ?? [];
    this.limit = json["limit"];
    this.offset = json["offset"];
    this.total = json["total"];
    this.location = json["location"];
    this.order = json["order"];
    this.from = json["from"];
    this.to = json["to"];
  }
}

class PlatformFee {
  dynamic fixed;
  dynamic amount;
  dynamic percentage;

  PlatformFee({this.fixed, this.amount, this.percentage});

  PlatformFee.fromJson(Map<String, dynamic> json) {
    this.fixed = json["fixed"];
    this.amount = json["amount"];
    this.percentage = json["percentage"];
  }
}

class TransactionFees {
  String? feeFlat;
  String? feeRate;
  String? vatRate;

  TransactionFees({this.feeFlat, this.feeRate, this.vatRate});

  TransactionFees.fromJson(Map<String, dynamic> json) {
    this.feeFlat = json["fee_flat"];
    this.feeRate = json["fee_rate"];
    this.vatRate = json["vat_rate"];
  }
}

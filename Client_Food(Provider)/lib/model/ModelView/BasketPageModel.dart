class BasketPageModel {
  String? restName;
  String? restAddress;
  double? sumPriceOrder;
  String? latitudeRest;
  String? longitudeRest;
  String? latitudeCust;
  String? longitudeCust;
  String? offerAmount;
  String? offerId;
  String? offerPercentage;
  String? offerPercenMax;
  String? offerPercenMin;
  bool? offerPercenStatus;
  String? rewardOption;
  String? rewardPoint;
  String? rewardPerc;
  int? rewardMinBuy;
  int? rewardMaxPrice;
  double? sumPriceOrderTotal;
  String? restId;
  double? minimumOrder;
  List<String>? paymentType;
  List<MenuList>? menuList;

  BasketPageModel(
      {this.restName,
      this.restAddress,
      this.sumPriceOrder,
      this.latitudeRest,
      this.longitudeRest,
      this.latitudeCust,
      this.longitudeCust,
      this.offerAmount,
      this.offerId,
      this.offerPercentage,
      this.offerPercenMax,
      this.offerPercenMin,
      this.offerPercenStatus,
      this.rewardOption,
      this.rewardPoint,
      this.rewardPerc,
      this.rewardMinBuy,
      this.rewardMaxPrice,
      this.sumPriceOrderTotal,
      this.restId,
      this.minimumOrder,
      this.paymentType,
      this.menuList});
}

class MenuList {
  String? menuHeader;
  int? menuPrice;
  int? menuPriceOrginal;
  String? menuDetail;
  int? menuSumPrice;
  int? menuNum;
  String? menuType;
  String? addOnName;
  int? addonPrice;
  String? menuId;
  String? menuSize;

  MenuList({
    this.menuHeader,
    this.menuPrice,
    this.menuPriceOrginal,
    this.menuDetail,
    this.menuSumPrice,
    this.menuNum,
    this.menuType,
    this.addOnName,
    this.addonPrice,
    this.menuId,
    this.menuSize,
  });
}

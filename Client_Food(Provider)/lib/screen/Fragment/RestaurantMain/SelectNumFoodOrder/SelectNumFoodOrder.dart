import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:/model/FromJSON/MenuDetailsModel.dart';
import 'package:/model/ModelView/BasketPageModel.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';

class SelectNumFoodOrder extends StatefulWidget {
  @override
  _SelectNumFoodOrder createState() => _SelectNumFoodOrder();
}

class _SelectNumFoodOrder extends State<SelectNumFoodOrder> {
  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Scaffold(
      bottomNavigationBar: Consumer<BasketPageProvider>(
        builder: (context, pvd, child) =>
            pvd.data == null || pvd.addOnSts == false
                ? constants.progressAPI()
                : buttonAddProduct(context),
      ),
      body: Consumer2<BasketPageProvider, RestaurantDetailProvider>(
        builder: (context, pvd, pvdrestdetail, child) => pvd.data == null ||
                pvd.addOnSts == false
            ? constants.progressAPI()
            : Container(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(children: [
                        backGroundPicture(context),
                        Visibility(
                            visible: pvd.data!.details!.menuDetails!.length > 1,
                            child: constants.typeTabBar(context, 'ตัวเลือก')),
                        menuOrder(),
                        addonPadding(),
                        addOnDetail(context),
                      ]),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget addonPadding() {
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.data!.mainAddon!.length > 0,
        child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7, right: 5),
            child: Divider(
              color: Color(0xFFE4E4E4),
              thickness: 10,
            )),
      ),
    );
  }

  Widget menuOrder() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLRTB,
        child: Column(
            children: List.generate(
          pvd.data!.details!.menuDetails!.length,
          (index) => Row(
            children: [
              Expanded(
                flex: 45,
                child: constants.fontStyleBold(
                    pvd.data!.details!.menuDetails![index].subName!,
                    fontSize: 22),
              ),
              Expanded(
                flex: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    constants.fontStyleRegular(
                        '(${constants.priceFormat(pvd.data!.details!.menuDetails![index].orginalPrice!)} ฿)',
                        fontSize: 22),
                    Radio(
                        value: int.parse(pvd
                            .data!.details!.menuDetails![index].statuSelected
                            .toString()),
                        groupValue: pvd.groupValue,
                        activeColor: Color(0xFFFEBC18),
                        onChanged: pvd.changeStatusSelectFood),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget backGroundPicture(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Stack(
        children: [
          Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(1, 3),
                  blurRadius: 2,
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: pvd.data!.details!.menuImage!,
              fit: BoxFit.fitWidth,
              errorWidget:
                  (BuildContext context, String pa, dynamic exception) {
                return Container(color: Colors.white, child: Text(''));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 15),
            child: InkWell(
                onTap: () => Navigator.pop(context),
                child: constants.closeMenuFood()),
          )
        ],
      ),
    );
  }

  Widget addOnDetail(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: !(pvd.data!.mainAddon!.length == 0 ||
            pvd.data!.details!.menuAddon!.toUpperCase() == 'NO'),
        child: Column(
          children: List.generate(
            pvd.data!.mainAddon!.length,
            (index) => Padding(
              padding: Constants.paddingAppLR,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      constants.fontStyleBold(
                          pvd.data!.mainAddon![index].mainaddonsName.toString(),
                          fontSize: 22.00,
                          colorValue: Color(0xFF3D525C)),
                      pvd.data!.mainAddon![index].status!
                          ? InkWell(
                              onTap: () =>
                                  pvd.changeStatusOpenAddon(index, false),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.amber))
                          : InkWell(
                              onTap: () =>
                                  pvd.changeStatusOpenAddon(index, true),
                              child: Icon(Icons.arrow_drop_up,
                                  color: Colors.amber))
                    ],
                  ),
                  constants.fontStyleBold(
                      pvd.minMaxaddonHeader(
                          pvd.data!.mainAddon![index].mainaddonsMiniCount!,
                          pvd.data!.mainAddon![index].mainaddonsCount!),
                      fontSize: 16.00,
                      colorValue: Colors.grey[500]),
                  Visibility(
                    visible: !pvd.data!.mainAddon![index].status!,
                    child: selectAddon(index, context),
                  ),
                  divider()
                ],
              ),
            ),
            //  ],
          ),
        ),
      ),
    );
  }

  Widget buttonAddProduct(BuildContext context) {
    var constants = Constants();
    return Consumer3<BasketPageProvider, RestaurantDetailProvider,
        AddressSavePageProvider>(
      builder: (context, pvd, pvdrestdetail, pvdAddress, child) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconAddAndRemove('remove'),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: constants.fontStyleRegular(pvd.numOrder.toString(),
                        fontSize: 35),
                  ),
                  iconAddAndRemove('add'),
                ],
              ),
            ),
            InkWell(
              onTap: () => {
                pvd
                    .checkRest(
                        pvdrestdetail.modelMenu!.result!.restDetails!.id
                            .toString(),
                        context)
                    .then((value) => {
                          pvdrestdetail.changeStatusBottomSheet(true),
                          if (value == false)
                            normalDialog(
                              context,
                              'หากคุณต้องการสั่งร้านใหม่ ออเดอร์ร้านเดิมจะถูกยกเลิก',
                              dialogYesNo: true,
                              onPressed: () => {
                                pvd.listBasket.clear(),
                                pvd.restId = pvdrestdetail
                                    .modelMenu!.result!.restDetails!.id
                                    .toString(),
                                pvd.sumNumOrderProd = 0,
                                pvd.sumPriceTotal = 0,
                                pvd.placeOrderModel.orderDescription = '',
                                pvd.placeOrderModel.riderDescription = '',
                                pvd.textFieldRest.text = '',
                                pvd.textFieldRider.text = '',
                                pvd.clearVoucher(),
                                pvd.selectOrder(),
                                getDetailOrderBasket(
                                    pvd, pvdrestdetail, pvdAddress),
                                Navigator.popUntil(context,
                                    ModalRoute.withName('/restaurantDetail')),
                              },
                            )
                          else
                            getDetailOrderBasket(pvd, pvdrestdetail, pvdAddress)
                        }),
              },
              child: Padding(
                padding: Constants.paddingAppLRB,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFFFEBC18),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: Constants.paddingAppLR,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(IconImport.basketflagment,
                                color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: constants.fontStyleBold('เพิ่มลงตะกร้า',
                                  fontSize: 22, colorValue: Colors.white),
                            ),
                          ],
                        ),
                        constants.fontStyleBold(
                            '${constants.priceFormat(pvd.sumPriceShow * pvd.numOrder)} ฿',
                            fontSize: 22,
                            colorValue: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDetailOrderBasket(
      BasketPageProvider pvd,
      RestaurantDetailProvider pvdrestdetail,
      AddressSavePageProvider pvdAddress) {
    pvd.getDetailOrder(
      modelBasket: new BasketPageModel(
        restAddress: pvdrestdetail.restDetails!.contactAddress!,
        restName: pvdrestdetail.restDetails!.restaurantName!,
        offerId: pvdrestdetail.modelMenu!.result!.offersDiscount!.offerId!,
        offerPercenStatus:
            pvdrestdetail.modelMenu!.result!.offersDiscount!.offerStatus!,
        offerPercentage:
            pvdrestdetail.modelMenu!.result!.offersDiscount!.offerPercentage!,
        offerPercenMax:
            pvdrestdetail.modelMenu!.result!.offersDiscount!.offerMaxPrice!,
        offerPercenMin:
            pvdrestdetail.modelMenu!.result!.offersDiscount!.offerMinPrice!,
        latitudeRest: pvdrestdetail.restDetails!.sourcelatitude,
        longitudeRest: pvdrestdetail.restDetails!.sourcelongitude!,
        latitudeCust: pvdAddress.showAddress.latitude,
        longitudeCust: pvdAddress.showAddress.longitude,
        rewardOption: pvdrestdetail.restDetails!.rewardOption,
        rewardMinBuy: pvdrestdetail.restDetails!.rewardMinBuy,
        rewardMaxPrice: pvdrestdetail.restDetails!.rewardMaxPrice,
        rewardPoint: pvdrestdetail.restDetails!.rewardPoint,
        rewardPerc: pvdrestdetail.restDetails!.rewardPerc,
        minimumOrder: pvdrestdetail.restDetails!.minimumOrder!,
        paymentType: paymentType(
            pvdrestdetail.modelMenu!.result!.restDetails!.restaurantPayments!),
        restId: pvdrestdetail.restDetails!.id.toString(),
      ),
    );
  }

  List<String> paymentType(List<RestaurantPayments> listPayment) {
    List<String> value = [];

    if (listPayment.length > 0) {
      listPayment.forEach((element) {
        value.add(element.paymentMethod!.id.toString());
      });
    }

    return value;
  }

  Widget iconAddAndRemove(String? text) {
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => InkWell(
        onTap: () => pvd.calnumOrder(text!),
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: Colors.black45)),
          child: Icon(
            text == 'add' ? Icons.add : Icons.remove,
            color: Colors.black54,
            //   size: 35,
          ),
        ),
      ),
    );
  }

  Widget selectAddon(int i, BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
        builder: (context, pvd, child) => Column(
                children: List.generate(
              pvd.listSubAdddonList[i].length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0))),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: Colors.green,
                          value: pvd.listSubAdddonList[i][index].statusSelect,
                          onChanged: (newValue) {
                            pvd.onSelectAddon(newValue!, i, index);
                          },
                        ),
                        constants.fontStyleRegular(
                            pvd.listSubAdddonList[i][index].subaddonsName
                                .toString(),
                            fontSize: 19),
                      ],
                    ),
                    constants.fontStyleRegular(
                        ' ${constants.priceFormat(pvd.listSubAdddonList[i][index].subaddonsPrice)} ฿',
                        fontSize: 19),
                  ],
                ),
              ),
            )));
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: Divider(
        color: Color(0x30FEBC18),
        thickness: 1,
      ),
    );
  }
}

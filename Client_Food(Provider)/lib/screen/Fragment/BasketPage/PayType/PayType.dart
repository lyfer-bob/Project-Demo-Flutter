import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/DialogsSuccess.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';

class PayType extends StatefulWidget {
  @override
  _PayType createState() => _PayType();
}

class _PayType extends State<PayType> {
  @override
  void initState() {
    Provider.of<BasketPageProvider>(context, listen: false)
        .initialPaymentType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();

    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => WillPopScope(
        onWillPop: () {
          pvd.checkInitPageby('byFragment');
          pvd.intitdata();

          Navigator.pop(context);

          return Future.value(false);
        },
        child: Scaffold(
            appBar: appBarPayType(context),
            body: Consumer2<BasketPageProvider, RestaurantDetailProvider>(
              builder: (context, pvdBasket, pvdRest, child) =>
                  pvdBasket.creditCardList == null || !pvdBasket.getPointSts
                      ? constants.progressAPI()
                      : CustomScrollView(
                          slivers: [
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  constants.typeTabBar(
                                      context, 'รายละเอียดออเดอร์',
                                      fontSize: 24),
                                  orderDescription(),
                                  getPoint(),
                                  noteForRest(context),
                                  noteForRider(context),
                                  constants.typeTabBar(
                                      context, 'ข้อมูลที่อยู่'),
                                  addressDetail(),
                                  codWidget(),
                                  creditCardWidget(),
                                  Visibility(
                                      visible: pvdBasket.promptpayPay ||
                                          pvdBasket.mobileBakingPay ||
                                          pvdBasket.trueWalletPay,
                                      child: constants.typeTabBar(
                                          context, 'การชำระอื่นๆ')),
                                  paymentList(),
                                  buttonSubmit(context),
                                ],
                              ),
                            )
                          ],
                        ),
            )),
      ),
    );
  }

  AppBar appBarPayType(BuildContext context) {
    var constants = Constants();
    return AppBar(
      leading: Consumer<BasketPageProvider>(
        builder: (context, pvd, child) =>
            constants.leadingBackIconAppBar(context, onPressed: () {
          pvd.checkInitPageby('byFragment');
          pvd.intitdata();
          Navigator.pop(context);
        }),
      ),
      title: constants.fontStyleBold('ยอดรวมคำสั่งซื้อ', fontSize: 21),
      flexibleSpace: constants.flexibleSpaceInAppBar(),
      actions: [
        Consumer<BasketPageProvider>(
          builder: (context, pvd, child) => Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: constants.fontStyleRegular(
                  '${constants.priceDecimal(pvd.model.sumPriceOrderTotal ?? 0)} ฿',
                  fontSize: 22),
            ),
          ),
        ),
      ],
    );
  }

  Widget getPoint() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.model.rewardOption.toString().toUpperCase() == 'NO'
            ? false
            : true,
        child: Column(
          children: [
            constants.typeTabBar(context, 'คะแนนที่ได้รับ', fontSize: 24),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            constants.pointSvgIcon(),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: constants.fontStyleRegular(
                                'คุณจะได้รับ ${pvd.modelGetRewards?.result?.earnPoint == null ? '0' : pvd.modelGetRewards?.result?.earnPoint} คะแนน',
                                fontSize: 21,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonSubmit(BuildContext context) {
    return Consumer2<BasketPageProvider, AddressSavePageProvider>(
      builder: (context, pvdBasket, pvdAddress, child) => Container(
        width: double.infinity,
        height: 120,
        color: Color(0xFFF3F3F3),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: ButtonAccept(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 45,
              backgroundColor:
                  pvdBasket.isSubmit ? Colors.black12 : Color(0xFFFEBC18),
              text: 'ชำระเงิน',
              fontStyleRegular: false,
              fontColor: Colors.white,
              onPressed: () async {
                if (!pvdBasket.isSubmit) {
                  pvdBasket.checkStsSubmit(true);
                  Constants().dialogProgress(context);
                  //ตรวจสอบปิดเปิดร้านค้า
                  if (await pvdBasket.checkRestCurrentStatus(context)) {
                    //ตรวจสอบยอดสั่งซื้อขั้นต่ำ
                    if (pvdBasket.placeOrderModel.paymentMethod == 'cod' ||
                        pvdBasket.placeOrderModel.ordertotalprice! >=
                            pvdBasket.ordderMinPriceOmise) {
                      //ตรวจสอบที่อยู่จัดส่ง
                      pvdAddress
                          .getDataSearch(
                              pvdAddress.showAddress.latitude,
                              pvdAddress.showAddress.longitude,
                              pvdBasket.model.latitudeRest!,
                              pvdBasket.model.longitudeRest!)
                          .then((value) {
                        if (pvdAddress.checkChangeAdress) {
                          pvdBasket.onSubmitOrder(context);
                        } else {
                          pvdBasket.checkFailLocationPay(context);
                        }
                      });
                    } else {
                      Constants().dialogProgress(context, pop: true);
                      normalDialog(context,
                          'ยอดสั่งซื้อขั้นต่ำต้องมากกว่า ${pvdBasket.ordderMinPriceOmise} บาท',
                          onPressed: () {
                        pvdBasket.checkStsSubmit(false);
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    Constants().dialogProgress(context, pop: true);
                    normalDialog(
                        context, 'ร้านค้าปิดบริการ กรุณาตรวจสอบอีกครั้ง');
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentList() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Padding(
        padding: Constants.paddingAppLRTB,
        child: Column(
          children: [
            payList(constants.promptpaySvgIcon(), 'Promptpay',
                pvdBasket.promptpayPay),
            payList(constants.mobileBankingSvgIcon(), 'MobileBanking',
                pvdBasket.mobileBakingPay),
            payList(constants.trueMoneyWalletSvgIcon(), 'TrueMoneyWallet',
                pvdBasket.trueWalletPay),
          ],
        ),
      ),
    );
  }

  Widget noteForRider(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Column(
        children: [
          constants.typeTabBar(context, 'หมายเหตุถึงไรเดอร์', fontSize: 24),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Align(
              alignment: Alignment.centerLeft,
              child: constants.textAutoNewLine(
                  pvdBasket.placeOrderModel.riderDescription ?? ' - ',
                  fontSize: 18,
                  colorValue: Color(0xFF7A7A7A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget noteForRest(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Column(
        children: [
          constants.typeTabBar(context, 'หมายเหตุถึงร้านค้า', fontSize: 24),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Align(
              alignment: Alignment.centerLeft,
              child: constants.textAutoNewLine(
                  pvdBasket.placeOrderModel.orderDescription ?? ' - ',
                  fontSize: 18,
                  colorValue: Color(0xFF7A7A7A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget orderDescription() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Padding(
        padding: Constants.paddingAppLRTB,
        child: Column(
          children: [
            rowOrderDetail(
                flag: 'header',
                name: 'รายการ',
                price: 'ราคา',
                num: 'จำนวน',
                sum: 'รวม'),
            Column(
              children: List.generate(
                pvdBasket.listBasket.length,
                (index) => rowOrderDetail(
                    flag: 'value',
                    name:
                        '${pvdBasket.listBasket[index].menuHeader}${pvdBasket.listBasket[index].menuDetail}',
                    price: constants.priceDecimal(
                        pvdBasket.listBasket[index].menuPrice ?? 0),
                    num: pvdBasket.listBasket[index].menuNum.toString(),
                    sum: constants.priceDecimal(
                        pvdBasket.listBasket[index].menuSumPrice ?? 0)),
              ),
            ),
            rowSumOrderDetail('ค่าอาหารรวม',
                '${constants.priceFormat(pvdBasket.model.sumPriceOrder ?? 0)} ฿'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Visibility(
                visible: pvdBasket.discout == 0 ? false : true,
                child: rowSumOrderDetail('คูปองส่วนลด',
                    '-${constants.priceFormat(pvdBasket.discout)} ฿'),
              ),
            ),
            Visibility(
                visible: (pvdBasket.model.offerPercenStatus ?? false) &&
                    double.parse(pvdBasket.model.offerAmount.toString()) > 0.00,
                child: rowSumOrderDetail(
                    'ข้อเสนอส่วนลด (${pvdBasket.model.offerPercentage}%)',
                    '-${pvdBasket.model.offerAmount} ฿')),
            Visibility(
                visible: pvdBasket.statusDiscountPoint,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: rowSumOrderDetail(
                      'แลกส่วนลด ( ${pvdBasket.model.rewardPerc}% ) ใช้คะแนน ${pvdBasket.model.rewardPoint} คะแนน',
                      '-${constants.priceFormat(pvdBasket.rewardDiscout)} ฿'),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: rowSumOrderDetail('ค่าจัดส่ง',
                    '${constants.priceFormat(pvdBasket.modelDelical?.result?.deliveryCost ?? 0)} ฿')),
            divider(),
            rowSumOrderDetail('ยอดรวมคำสั่งซื้อ',
                '${constants.priceFormat(pvdBasket.model.sumPriceOrderTotal ?? 0)} ฿'),
          ],
        ),
      ),
    );
  }

  Widget creditCardWidget() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
        builder: (context, pvdBasket, child) => Visibility(
              visible: pvdBasket.creditCardPay,
              child: Column(
                children: [
                  constants.typeTabBar(context, 'บัตรเครดิต / เดบิต'),
                  Padding(
                      padding: Constants.paddingAppLRTB,
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(
                              pvdBasket.creditCardList!.length,
                              (index) => Column(
                                children: [listCreditCard(index), divider()],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFFFEBC18),
                                size: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  pvdBasket.resetCreditCard();
                                  Navigator.pushNamed(context, '/creditCard');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: constants.fontStyleBold(
                                      'เพิ่มบัตรใหม่',
                                      fontSize: 18,
                                      colorValue: Color(0xFFFEBC18)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ));
  }

  Widget codWidget() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Visibility(
        visible: pvdBasket.codPay,
        child: Column(
          children: [
            constants.typeTabBar(context, 'จ่ายด้วยเงินสด'),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(IconImport.cashondeliveryicon),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            constants.fontStyleRegular('เก็บเงินปลายทาง',
                                fontSize: 18),
                            constants.fontStyleRegular(
                                'โปรดเตรียมเงินสดในการชำระเงิน',
                                fontSize: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => pvdBasket.checkSelectPayType('cod'),
                    child: Icon(Icons.check_circle,
                        color: pvdBasket.colorCod
                            ? Color(0xFF40C057)
                            : Color(0xFFE4E4E4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listCreditCard(int index) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              pvdBasket.creditCardList![index].cardBrand == 'Visa'
                  ? Icon(IconImport.cc_visa, size: 16)
                  : pvdBasket.creditCardList![index].cardBrand == 'MasterCard'
                      ? Icon(IconImport.cc_mastercard, size: 16)
                      : Icon(IconImport.credit_card_alt, size: 16),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: constants.fontStyleRegular(
                    'xxxx xxxx xxxx ${pvdBasket.creditCardList![index].cardNumber}',
                    fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () =>
                      pvdBasket.onClickDeleteCreditCard(context, index),
                  child:
                      Icon(IconImport.trashicon, color: Colors.red, size: 17.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: InkWell(
                    onTap: () => pvdBasket.checkSelectPayType('creditcard',
                        index: index),
                    child: Icon(Icons.check_circle,
                        color: pvdBasket.creditCardList![index].statusSelect!
                            ? Color(0xFF40C057)
                            : Color(0xFFE4E4E4)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget payList(var icon, String text, bool statusPay) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Visibility(
          visible: statusPay,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: constants.fontStyleRegular(text, fontSize: 18),
                  ),
                ],
              ),
              onClickPayType(text),
            ],
          ),
        ),
      ),
    );
  }

  Widget onClickPayType(String payType) {
    return Consumer<BasketPageProvider>(
      builder: (context, pvdBasket, child) => InkWell(
        onTap: () => pvdBasket.checkSelectPayType(payType),
        child: Icon(Icons.check_circle,
            color: pvdBasket.colorPayType(payType)
                ? Color(0xFF40C057)
                : Color(0xFFE4E4E4)),
      ),
    );
  }

  Widget addressDetail() {
    var constants = Constants();
    return Consumer2<AddressSavePageProvider, BasketPageProvider>(
      builder: (context, pvd, pvdBasket, child) => pvd.showAddress.title == ''
          ? Text('')
          : Padding(
              padding: Constants.paddingAppLRTB,
              child: InkWell(
                onTap: () => {
                  pvdBasket.openbyCheckoutPageSts(true),
                  Navigator.pushNamed(context, '/addressSelected')
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        pvdBasket.placeOrderModel.addressTitle ==
                                'ที่อยู่ปัจจุบัน'
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: constants.fontStyleBold(
                                    'กรุณาเพิ่มที่อยู่',
                                    fontSize: 18),
                              )
                            : Row(
                                children: [
                                  Icon(pvdBasket.placeOrderModel.addressTitle ==
                                              'Home' ||
                                          pvdBasket.placeOrderModel
                                                  .addressTitle ==
                                              'บ้าน'
                                      ? Icons.home
                                      : pvdBasket.placeOrderModel
                                                      .addressTitle ==
                                                  'Office' ||
                                              pvdBasket.placeOrderModel
                                                      .addressTitle ==
                                                  'ออฟฟิศ'
                                          ? IconImport.officeicon
                                          : IconImport.location),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: constants.fontStyleBold(
                                        pvdBasket
                                                .placeOrderModel.addressTitle ??
                                            '',
                                        fontSize: 16.5),
                                  ),
                                ],
                              ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        )
                      ],
                    ),
                    Visibility(
                      visible: pvdBasket.placeOrderModel.addressTitle !=
                          'ที่อยู่ปัจจุบัน',
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: constants.textAutoNewLine(
                            'เลขที่ ${pvd.showAddress.addressId}  , ${pvd.showAddress.address}',
                            fontSize: 16.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget rowSumOrderDetail(String header, String value) {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          constants.fontStyleRegular(header,
              fontSize: header == 'ยอดรวมคำสั่งซื้อ' ? 20 : 18,
              colorValue: Color(0xFF3D525C)),
          constants.fontStyleRegular(value,
              fontSize: header == 'ยอดรวมคำสั่งซื้อ' ? 25 : 18,
              colorValue: Color(0xFF3D525C)),
        ],
      ),
    );
  }

  Widget rowOrderDetail(
      {String? flag, String? name, String? price, String? num, String? sum}) {
    var constants = Constants();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 55,
              child: Padding(
                padding: flag == 'header'
                    ? const EdgeInsets.only(left: 20.0)
                    : const EdgeInsets.all(0),
                child: constants.textAutoNewLine(name!,
                    fontSize: 18, colorValue: Color(0xFF3D525C)),
              ),
            ),
            Expanded(
                flex: 25,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: constants.fontStyleRegular(
                        flag == 'header'
                            ? price!
                            : '${constants.priceFormat(price)}  ฿',
                        fontSize: 18,
                        colorValue: Color(0xFF3D525C)),
                  ),
                )),
            Expanded(
                flex: 20,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Center(
                    child: constants.fontStyleRegular(num!, fontSize: 18),
                  ),
                )),
            Expanded(
                flex: 20,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: constants.fontStyleRegular(
                        //ถ้า header ไม่ต้องมี ฿ ตามหลัง
                        flag == 'header'
                            ? sum!
                            : '${constants.priceFormat(sum)} ฿',
                        fontSize: 18,
                        colorValue: Color(0xFF3D525C)))),
          ],
        ),
        divider(),
      ],
    );
  }

  Widget rowAddress(String name, int index) {
    var constants = Constants();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            index == 0
                ? Icon(Icons.home)
                : index == 1
                    ? Icon(IconImport.officeicon)
                    : Icon(IconImport.location),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: constants.fontStyleRegular(name, fontSize: 18),
            ),
          ],
        ),
        InkWell(child: Icon(Icons.check_circle, color: Color(0xFF40C057)))
      ],
    );
  }

  Widget rowDetail(String header, String value) {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: constants.fontStyleRegular(header,
                  fontSize: 18, colorValue: Color(0xFF3D525C)),
            ),
            Expanded(
                flex: 7, //ถ้า header ไม่มี ไม่ต้องใส่ : มาหน้า value
                child: constants.textAutoNewLine(
                    '${header == '' ? ' ' : ':'} $value',
                    fontSize: 18,
                    colorValue: Color(0xFF7A7A7A)))
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Divider(
        color: Color(0xFFE4E4E4),
        thickness: 1,
      ),
    );
  }
}

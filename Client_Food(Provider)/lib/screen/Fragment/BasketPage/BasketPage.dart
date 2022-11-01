import 'package:flutter/material.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';
import '../FragmentProvider.dart';

class BasketPage extends StatefulWidget {
  @override
  _BasketPage createState() => _BasketPage();
}

class _BasketPage extends State<BasketPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<FragmentProvider>(context, listen: false)
        .initKeyboardCheckBasketIcon();

    Provider.of<BasketPageProvider>(context, listen: false).intitdata();
  }

  @override
  void dispose() {
    Provider.of<FragmentProvider>(context, listen: false)
        .disposeKeyBoardSigninPage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Consumer4<BasketPageProvider, FragmentProvider,
        RestaurantDetailProvider, GlobalURLProvider>(
      builder: (context, pvd, pvdFragment, pvdRestDetail, pvdGlobal, child) =>
          Scaffold(
        appBar: appBarBasket(constants, pvd, pvdRestDetail, context),
        body: !pvdFragment.stsSigin
            ? Center(
                child: constants.fontStyleRegular('คุณยังไม่ได้ทำการ Login',
                    fontSize: 50, colorValue: Color(0xFFCECECE)),
              )
            : pvd.modelDelical == null &&
                    pvd.flagPage == 'byFragment' &&
                    pvd.listBasket.length == 0
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          IconImport.basketicon,
                          color: Colors.amber,
                          size: 100,
                        ),
                        constants.fontStyleBold('ไม่มีสินค้าในตะกร้า',
                            fontSize: 20),
                      ],
                    ),
                  )
                : (pvd.modelDelical == null && pvd.deliveryChargeSts) &&
                        (pvd.flagPage == 'byBottomSheet' ||
                            pvd.flagPage == 'byFragment')
                    ? constants.progressAPI()
                    : ((pvd.listBasket.length == 0 &&
                                pvd.model.paymentType!.length == 0) ||
                            !pvd.deliveryChargeSts && pvd.modelDelical == null)
                        ? systemError(context)
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
                                    restDetail(context),
                                    divider(),
                                    foodOrderDetail(context),
                                    noteforRestAndRider(),
                                    constants.typeTabBar(
                                        context, 'รายละเอียดอาหาร',
                                        fontSize: 24),
                                    orderDetail(),
                                    spacing(),
                                    couponDiscount(context),
                                    buttonSubmit(),
                                    spacing(),
                                  ],
                                ),
                              ),
                            ],
                          ),
      ),
    );
  }

  systemError(BuildContext context) {
    var constants = Constants();

    return Consumer4<BasketPageProvider, FragmentProvider,
        RestaurantDetailProvider, GlobalURLProvider>(
      builder: (context, pvd, pvdFragment, pvdRestDetail, pvdGlobal, child) =>
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            constants.fontStyleRegular('ไม่สามารถสั่งอาหารได้',
                fontSize: 50, colorValue: Color(0xFFCECECE)),
            constants.fontStyleRegular('กรุณาติดต่อผู้ดูแลระบบ',
                fontSize: 50, colorValue: Color(0xFFCECECE)),
            constants.fontStyleRegular(pvdGlobal.callCenterNumber,
                fontSize: 50, colorValue: Color(0xFFCECECE)),
            Visibility(
              visible: pvd.model.paymentType!.length == 0,
              child: constants.fontStyleRegular('PaymentType',
                  fontSize: 50, colorValue: Color(0xFFCECECE)),
            ),
            Visibility(
              visible: !pvd.deliveryChargeSts && pvd.modelDelical == null,
              child: constants.fontStyleRegular('DeliveryCalculate',
                  fontSize: 50, colorValue: Color(0xFFCECECE)),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBarBasket(Constants constants, BasketPageProvider pvdBastket,
      RestaurantDetailProvider pvdRestDetail, BuildContext context) {
    return AppBar(
      title: constants.fontStyleBold('ตะกร้า', fontSize: 21),
      flexibleSpace: constants.flexibleSpaceInAppBar(),
      leading: pvdBastket.flagPage == 'byBottomSheet'
          ? constants.leadingBackIconAppBar(context, onPressed: () {
              pvdRestDetail.getRestaurantDetail(
                  pvdBastket.model.restId.toString(), context);

              Navigator.pushNamed(context, '/restaurantDetail');
            })
          : null,
      automaticallyImplyLeading: false,
    );
  }

  Widget buttonSubmit() {
    var constants = Constants();
    return Consumer2<BasketPageProvider, AddressSavePageProvider>(
      builder: (context, pvd, pvdaddress, child) => Container(
        width: double.infinity,
        height: 100,
        color: Color(0xFFF3F3F3),
        child: Padding(
          padding: EdgeInsets.only(
              top: 15.0,
              bottom: 10,
              right: MediaQuery.of(context).size.width * 0.1,
              left: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible:
                    pvd.model.minimumOrder! > (pvd.model.sumPriceOrder ?? 0.0),
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: constants.fontStyleRegular(
                      'ยอดขั้นต่ำ ${pvd.model.minimumOrder!.ceil()} บาท',
                      fontSize: 18,
                    )),
              ),
              ButtonAccept(
                width: MediaQuery.of(context).size.width,
                height: 45,
                backgroundColor:
                    pvd.model.minimumOrder! > (pvd.model.sumPriceOrder ?? 0.0)
                        ? Colors.black12
                        : Color(0xFFFEBC18),
                onPressed: () {
                  if (pvd.model.sumPriceOrder != null &&
                      (pvd.model.minimumOrder! <= pvd.model.sumPriceOrder!))
                    pvd.onSubmit(context,
                        addressTitle: pvdaddress.showAddress.title,
                        addressId: pvdaddress.showAddress.id);
                },
                text: 'ชำระเงิน',
                fontStyleRegular: false,
                fontColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget couponDiscount(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLRT,
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      IconImport.ticketicon,
                      color: Color(0xFF1492E6),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          constants.fontStyleRegular(pvd.couponeCode,
                              fontSize: 17, colorValue: Color(0xFF1492E6)),
                          Visibility(
                            visible: pvd.couponeCode == 'ใส่รหัสส่วนลด'
                                ? false
                                : true,
                            child: InkWell(
                              onTap: () => pvd.clearVoucherAndSumOrderPrice(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, left: 5),
                                child: Icon(
                                  Icons.highlight_remove,
                                  color: Color(0xFFFC6969),
                                  size: 17.5,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: InkWell(
                  onTap: () {
                    pvd.clearAndGetListCoupon();

                    Navigator.pushNamed(context, '/couponDiscount');
                  },
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: constants.fontStyleRegular('ใช้คูปอง',
                              fontSize: 17, colorValue: Color(0xFF1492E6))),
                      Icon(Icons.arrow_forward_ios,
                          color: Color(0xFFC0C0C0), size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderDetail() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLRT,
        child: Column(
          children: [
            rowFoodDetail(
                'ค่าอาหารรวม',
                pvd.model.sumPriceOrder == null
                    ? ''
                    : constants.priceFormat(pvd.model.sumPriceOrder!)),
            // rowFoodDetail('ค่าจัดส่ง',
            //     pvd.checkDelivery()),
            Visibility(
              visible: pvd.discout == 0 ? false : true,
              child: rowFoodDetail(
                  'ส่วนลด', constants.priceFormat(pvd.discout.toString())),
            ),
            Visibility(
              visible: (pvd.model.offerPercenStatus! &&
                      double.parse((pvd.model.offerAmount ?? '0')) > 0) &&
                  pvd.model.offerPercenStatus!,
              child: rowFoodDetail(
                  'ข้อเสนอส่วนลด (${pvd.model.offerPercentage}%)',
                  constants.priceFormat('-${pvd.model.offerAmount ?? 0}')),
            ),
            rowFoodDetailCheckDiscount(),
            rowFoodDetail(
                'ยอดรวมคำสั่งซื้อ',
                pvd.model.sumPriceOrderTotal == null
                    ? ''
                    : constants.priceFormat(pvd.model.sumPriceOrderTotal! -
                        double.parse(
                            pvd.modelDelical!.result!.deliveryCost.toString())),
                fontSize: 22,
                stsdivider: false),
          ],
        ),
      ),
    );
  }

  Widget noteforRestAndRider() {
    var constants = Constants();
    return Padding(
      padding: Constants.paddingAppLR,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          constants.fontStyleRegular('หมายเหตุถึงร้านค้า', fontSize: 21),
          textField('เพิ่มหมายเหตุถึงร้านค้า', 'ร้านค้า'),
          constants.fontStyleRegular('หมายเหตุถึงคนขับ', fontSize: 21),
          textField('เพิ่มหมายเหตุถึงคนขับ', 'คนขับ'),
        ],
      ),
    );
  }

  Widget restDetail(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLR,
        child: Visibility(
          visible: pvd.model.restName == null ? false : true,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                constants.fontStyleRegular(pvd.model.restName.toString(),
                    fontSize: 20),
                constants.fontStyleRegular(pvd.model.restAddress.toString(),
                    fontSize: 17)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget spacing() {
    return Container(
      width: double.infinity,
      height: 20,
      color: Color(0xFFF3F3F3),
    );
  }

  Widget rowFoodDetailCheckDiscount() {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.model.sumPriceOrderTotal != null &&
            pvd.checkStatusDiscountByReward(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20, // set เพื่อให้ checkbok ตรงกับแถว
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: Colors.green,
                        value: pvd.statusDiscountPoint,
                        onChanged: (newValue) {
                          pvd.changeStatusDiscount(newValue!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: constants.fontStyleRegular(
                          'แลกส่วนลด ( ${pvd.model.rewardPerc}% ) ใช้คะแนน ${pvd.model.rewardPoint} คะแนน',
                          fontSize: 21),
                    ),
                  ],
                ),
                constants.fontStyleRegular('-${pvd.rewardDiscout} ฿',
                    fontSize: 21),
              ],
            ),
            divider(),
          ],
        ),
      ),
    );
  }

  Widget foodOrderDetail(BuildContext context) {
    var constants = Constants();
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.listBasket == [] ? false : true,
        child: Padding(
          padding: Constants.paddingAppLR,
          child: Column(
            children: List.generate(
              pvd.listBasket.length,
              (index) => Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constants.textAutoNewLine(
                                  '${pvd.listBasket[index].menuHeader} (${pvd.listBasket[index].menuPriceOrginal} ฿)',
                                  fontSize: 19.75),
                              Visibility(
                                visible: pvd.listBasket[index].menuDetail == ''
                                    ? false
                                    : true,
                                child: constants.textAutoNewLine(
                                  '${pvd.listBasket[index].menuDetail}',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 45,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        pvd.removeOrder(index);

                                        pvd.changeDataBottomSheet(
                                            pvd.sumNumOrder,
                                            pvd.model.sumPriceOrder!);
                                      },
                                      child: Icon(
                                        Icons.remove_circle_outline,
                                        color: Color(0xFFFEBC18),
                                        size: 25,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: constants.fontStyleRegular(
                                          pvd.listBasket[index].menuNum
                                              .toString(),
                                          fontSize: 19.75),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        pvd.addOrder(index);

                                        pvd.changeDataBottomSheet(
                                            pvd.sumNumOrder,
                                            pvd.model.sumPriceOrder!);
                                      },
                                      child: Icon(
                                        Icons.add_circle_outline,
                                        color: Color(0xFFFEBC18),
                                        size: 25,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: constants.fontStyleRegular(
                                          '${constants.priceFormat(pvd.listBasket[index].menuSumPrice)} ฿',
                                          fontSize: 21),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    pvd.deleteOrder(index);

                                    pvd.changeDataBottomSheet(pvd.sumNumOrder,
                                        pvd.model.sumPriceOrder!);
                                  },
                                  child: Icon(
                                    IconImport.trashicon,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget rowFoodDetail(String header, String data,
      {double? fontSize, bool? stsdivider}) {
    var constants = Constants();
    stsdivider ??= true;
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              constants.fontStyleRegular(header, fontSize: fontSize ?? 21),
              constants.fontStyleRegular(
                  data == 'Free'
                      ? 'Free'
                      : header == 'ส่วนลด'
                          ? '-$data ฿'
                          : '$data ฿',
                  fontSize: fontSize ?? 21),
            ],
          ),
          stsdivider == true ? divider() : Text(''),
        ],
      ),
    );
  }

  Widget textField(String hintText, String flag) {
    return Consumer<BasketPageProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 15),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black12,
              width: 0.45,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller:
                  flag == 'ร้านค้า' ? pvd.textFieldRest : pvd.textFieldRider,
              onChanged: (value) => pvd.onchangeRemark(value, flag),
              cursorWidth: 1,
              cursorColor: Colors.black,
              style: TextStyle(
                  fontFamily: 'THSarabun',
                  fontSize: 21,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
              maxLines: 1,
              decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontFamily: 'THSarabun',
                      fontSize: 21,
                      color: Color(0xff737373),
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
      child: Divider(
        color: Color(0xFFE4E4E4),
        thickness: 1,
      ),
    );
  }
}

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:/blocs/auth_bloc.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/screen/chat/providers/ChatArgument_provider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../FragmentProvider.dart';

class DetailDelivery extends StatefulWidget {
  @override
  _DetailDelivery createState() => _DetailDelivery();
}

class _DetailDelivery extends State<DetailDelivery> {
  @override
  void initState() {
    super.initState();
    Provider.of<DetailDeliveryProvider>(context, listen: false).intitdata();
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer2<DetailDeliveryProvider, FragmentProvider>(
        builder: (context, pvd, pvdFragment, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Consumer<DetailDeliveryProvider>(
              builder: (context, pvd, child) =>
                  pvd.model == null || pvd.stsLoading == false
                      ? Text('')
                      : constants.fontStyleBold('ออเดอร์ : ${pvd.orderNumber}',
                          fontSize: 21),
            ),
            flexibleSpace: constants.flexibleSpaceInAppBar(),
            leading: constants.leadingBackIconAppBar(context, onPressed: () {
              pvd.stopLoading();
              if (pvd.page == 'noti' && pvdFragment.currentIndex != 3) {
                Navigator.pop(context);
              } else if (pvdFragment.currentIndex == 3) {
                Navigator.popUntil(context, ModalRoute.withName('/fragment'));
                pvdFragment.changeIndexpage(3);
              } else {
                Navigator.popUntil(context, ModalRoute.withName('/fragment'));
                pvdFragment.changeIndexpage(1, context: context);
              }
            }),
          ),
          floatingActionButton:
              Consumer2<DetailDeliveryProvider, ChatArgumentProvider>(
            builder: (context, pvd, chatArgumentProviderValue, child) =>
                Visibility(
              visible: pvd.stsLoading &&
                  !(pvd.orderDetail!.orderStatusText! == 'ยกเลิก' ||
                      pvd.orderDetail!.orderStatusText! == 'จัดส่งเรียบร้อย'),
              child: InkWell(
                onTap: () => {
                  showBottomSheetGraphCard(context),
                  pvd.onChangeStatusRedPoint(),
                },
                child: pvd.orderDetail?.customerId != null &&
                        pvd.model?.result?.driverDetail != null
                    ? Stack(
                        children: [
                          circleBox(
                            Badge(
                              badgeColor: const Color(0xffd42400),
                              showBadge: chatArgumentProviderValue
                                      .isHaveChatNoticCustomerRider ||
                                  chatArgumentProviderValue
                                      .isHaveChatNoticCustomerRestaurant,

                              //badgeContent: Text('3'),
                              position: BadgePosition.topEnd(top: -2, end: -2),
                              child: Icon(IconImport.contactrestandrider,
                                  size: 30),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: 5,
                      ),
              ),
            ),
          ),
          body: Consumer2<DetailDeliveryProvider, FragmentProvider>(
            builder: (context, pvd, pvdFragment, child) =>
                pvd.model == null || pvd.stsLoading == false
                    ? constants.progressAPI()
                    : CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        // closeButton(context),
                                        imageBackground(context),
                                      ],
                                    ),
                                    statusText(),
                                    timerDetail(),
                                    statusAndDetailDelivery(context),
                                    cancelStatus(context),
                                    constants.typeTabBar(context, 'รายละเอียด',
                                        fontSize: 24),
                                    orderDescription(),
                                  ]),
                                ),
                                constants.typeTabBar(
                                    context, 'รายละเอียดออเดอร์',
                                    fontSize: 24),
                                orderDetails(),
                                noteForRest(context),
                                noteForRider(context),
                                spacing(),
                                getPoint(),
                                restDescription(),
                                custDescription(),
                                riderDescription(context),
                              ],
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  Widget statusText() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => constants.fontStyleBold(
          pvd.orderDetail!.orderStatusText!,
          fontSize: 30,
          colorValue: pvd.orderDetail!.orderStatusText! == 'ยกเลิก'
              ? Colors.red
              : Color(0xFF40C057)),
    );
  }

  Widget timerDetail() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: !(pvd.orderDetail!.orderStatusText! == 'ยกเลิก' ||
            pvd.orderDetail!.orderStatusText! == 'จัดส่งเรียบร้อย' ||
            pvd.orderDetail!.timeRemain.toString() == '0'),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10),
              child: constants.fontStyleRegular('คุณจะได้รับอาหาร โดยประมาณ ',
                  fontSize: 18, colorValue: Color(0xFF7A7A7A)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                constants.fontStyleRegular(
                    '${pvd.orderDetail!.timeRemain!} นาที',
                    fontSize: 30,
                    colorValue: Color(0xFF3D525C)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget riderDescription(BuildContext context) {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.driverSts,
        child: Column(
          children: [
            constants.typeTabBar(context, 'รายละเอียดไรเดอร์', fontSize: 24),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: riderDetail(),
            ),
          ],
        ),
      ),
    );
  }

  Widget restDescription() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Column(
        children: [
          constants.typeTabBar(context, 'รายละเอียดร้านค้า', fontSize: 24),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Column(
              children: [
                rowDetail('ชื่อร้านอาหาร', pvd.storeDetail!.name!),
                rowDetail('เบอร์ร้านอาหาร', pvd.storeDetail!.phone!),
                rowDetail('ที่อยู่ร้านอาหาร', pvd.storeDetail!.address!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget custDescription() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Column(
        children: [
          constants.typeTabBar(context, 'รายละเอียดลูกค้า', fontSize: 24),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Column(
              children: [
                rowDetail('ชื่อลูกค้า', pvd.custDetail!.name!),
                rowDetail('ที่อยู่', pvd.custDetail!.address ?? ' - '),
                rowDetail(
                    'อีเมล',
                    pvd.custDetail!.email!.isNotEmpty
                        ? pvd.custDetail!.email!
                        : ' - '),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getPoint() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLRTB,
        child: Row(
          children: [
            constants.pointSvgIcon(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: constants.fontStyleRegular(
                  'คุณจะได้รับ ${pvd.orderDetail!.orderPoint!} คะแนน',
                  fontSize: 18,
                  colorValue: Color(0xFF7A7A7A)),
            )
          ],
        ),
      ),
    );
  }

  Widget noteForRider(BuildContext context) {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.orderDetail!.driverRemark! == '' ? false : true,
        child: Column(
          children: [
            constants.typeTabBar(context, 'หมายเหตุถึงไรเดอร์', fontSize: 24),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: Align(
                alignment: Alignment.centerLeft,
                child: constants.textAutoNewLine(pvd.orderDetail!.driverRemark!,
                    fontSize: 18, colorValue: Color(0xFF7A7A7A)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noteForRest(BuildContext context) {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.orderDetail!.orderdescrption! == '' ? false : true,
        child: Column(
          children: [
            constants.typeTabBar(context, 'หมายเหตุถึงร้านค้า', fontSize: 24),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: Align(
                alignment: Alignment.centerLeft,
                child: constants.textAutoNewLine(
                    pvd.orderDetail!.orderdescrption!,
                    fontSize: 18,
                    colorValue: Color(0xFF7A7A7A)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderDetails() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Padding(
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
                pvd.productdetail!.length,
                (index) => rowOrderDetail(
                    flag: 'value',
                    name:
                        '${pvd.productdetail![index].productname}${pvd.productdetail![index].subaddonsName}',
                    price:
                        constants.priceFormat(pvd.productdetail![index].price),
                    num: pvd.productdetail![index].quantity.toString(),
                    sum:
                        constants.priceFormat(pvd.productdetail![index].total)),
              ),
            ),
            rowSumOrderDetail('ค่าอาหารรวม',
                '${constants.priceFormat(pvd.orderDetail!.subTot)} ฿'),
            Visibility(
              visible: pvd.orderDetail!.voucherAmount == 0 ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: rowSumOrderDetail('คูปองส่วนลด',
                    '-${constants.priceFormat(pvd.orderDetail!.voucherAmount)} ฿'),
              ),
            ),
            Visibility(
              visible: pvd.orderDetail!.offer == 0 ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: rowSumOrderDetail(
                    'ข้อเสนอส่วนลด (${pvd.orderDetail!.offerPercentage}%)',
                    '-${constants.priceFormat(pvd.orderDetail!.offer)} ฿'),
              ),
            ),
            Visibility(
              visible: pvd.orderDetail!.rewardOffer == 0 ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: rowSumOrderDetail(
                    'แลกส่วนลด (${pvd.orderDetail!.rewardOfferPercentage}%)',
                    '-${constants.priceFormat(pvd.orderDetail!.rewardOffer)} ฿'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: rowSumOrderDetail(
                    'ค่าจัดส่ง',
                    constants.priceFormat(pvd.orderDetail!.delivery) == '0.00'
                        ? 'ฟรีค่าส่ง'
                        : '${constants.priceFormat(pvd.orderDetail!.delivery)} ฿')),
            divider(),
            rowSumOrderDetail('ยอดรวมคำสั่งซื้อ',
                '${constants.priceFormat(pvd.orderDetail!.grandTot)} ฿'),
          ],
        ),
      ),
    );
  }

  Widget orderDescription() {
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLRTB,
        child: Column(
          children: [
            rowDetail('หมายเลขออเดอร์', pvd.orderNumber),
            rowDetail(
                'การชำระเงิน',
                pvd.orderDetail!.paymentType! == 'cod'
                    ? 'เก็บเงินปลายทาง'
                    : pvd.orderDetail!.paymentType! == 'omise_credit_card'
                        ? 'บัตรเครดิต'
                        : pvd.orderDetail!.paymentType!),
            rowDetail('รูปแบบการสั่ง', pvd.orderDetail!.orderType!),
            rowDetail('วันสั่งอาหาร', pvd.orderDetail!.orderDate!),
            rowDetail('เวลาสั่งอาหาร', pvd.orderDetail!.orderTime!),
            rowDetail('สถานะการสั่ง', 'สั่งซื้อแล้ว'),
            rowDetail(
                'สถานะการจ่าย',
                pvd.orderDetail!.paymentStatus == "P"
                    ? "ชำระเงินแล้ว"
                    : "ยังไม่ได้ชำระเงิน"),
          ],
        ),
      ),
    );
  }

  Widget cancelStatus(BuildContext context) {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Visibility(
        visible: pvd.orderDetail!.orderStatusText! == 'ยกเลิก',
        child: Column(
          children: [
            constants.typeTabBar(context, 'รายละเอียดการยกเลิก', fontSize: 24),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: Column(
                children: [
                  rowDetail('ยกเลิกโดย', pvd.orderDetail!.cancelType ?? ' - '),
                  rowDetail('สาเหตุ', pvd.orderDetail!.cancelReason ?? ' - '),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageBackground(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Image.asset(
          'assets/images/ReciveOrder.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return Consumer2<DetailDeliveryProvider, FragmentProvider>(
      builder: (context, pvd, pvdFragment, child) => InkWell(
        onTap: () {
          pvd.stopLoading();
          if (pvd.page == 'noti' && pvdFragment.currentIndex != 3) {
            Navigator.pop(context);
          } else if (pvdFragment.currentIndex == 3) {
            Navigator.popUntil(context, ModalRoute.withName('/fragment'));
            pvdFragment.changeIndexpage(3);
          } else {
            Navigator.popUntil(context, ModalRoute.withName('/fragment'));
            pvdFragment.changeIndexpage(1);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close, size: 30)),
        ),
      ),
    );
  }

  Widget riderDetail() {
    var constants = Constants();
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: CachedNetworkImage(
                  imageUrl: pvd.driverDetail!.urlImg!, fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                constants.fontStyleRegular(pvd.driverDetail!.driverName!,
                    fontSize: 18, colorValue: Color(0xFF3D525C)),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Icon(
                          Icons.star,
                          size: 18,
                          color: Color(0xFFFEBC18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: constants.fontStyleRegular(
                            '${pvd.driverDetail!.scoreReview}/5',
                            fontSize: 18,
                            colorValue: Color(0xFF3D525C)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 8),
                        child: Icon(
                          IconImport.phone,
                          size: 20,
                          color: Color(0xFF40C057),
                        ),
                      ),
                      constants.fontStyleRegular(pvd.driverDetail!.driverPhone!,
                          fontSize: 18, colorValue: Color(0xFF7A7A7A)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
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
              flex: 6,
              child: Padding(
                padding: flag == 'header'
                    ? const EdgeInsets.only(left: 20.0)
                    : const EdgeInsets.all(0),
                child: constants.textAutoNewLine(name!,
                    fontSize: 18, colorValue: Color(0xFF3D525C)),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: constants.fontStyleRegular(
                        flag == 'header' ? price! : '$price ฿',
                        fontSize: 18,
                        colorValue: Color(0xFF3D525C)),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Center(
                    child: constants.fontStyleRegular(num!, fontSize: 18),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: constants.fontStyleRegular(
                        //ถ้า header ไม่ต้องมี ฿ ตามหลัง
                        flag == 'header' ? sum! : '$sum ฿',
                        fontSize: 18,
                        colorValue: Color(0xFF3D525C)))),
          ],
        ),
        divider(),
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

  Widget statusAndDetailDelivery(BuildContext context) {
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    statusDelievery(
                        Icon(IconImport.reciveorder,
                            color: pvd.colorSuccess[0]),
                        pvd.colorSuccess[0],
                        'รับออเดอร์'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child:
                          lineStatusDelivery(pvd.orderDetail!.percentToShop!),
                    ),
                    statusDelievery(
                        Icon(
                          IconImport.reststatus,
                          color: pvd.colorSuccess[1],
                        ),
                        pvd.colorSuccess[1],
                        'ถึงร้านค้า'),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child:
                          lineStatusDelivery(pvd.orderDetail!.percentToClient!),
                    ),
                    statusDelievery(
                        Icon(
                          IconImport.delisuccessstatus,
                          color: pvd.colorSuccess[2],
                        ),
                        pvd.colorSuccess[2],
                        'จัดส่งเรียบร้อย'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget lineStatusDelivery(int percLoad) {
    return Consumer<DetailDeliveryProvider>(
      builder: (context, pvd, child) => LinearPercentIndicator(
        padding: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width * 0.15,
        animation: true,
        lineHeight: 3.0,
        backgroundColor: Color(0xFFA19F9F),
        animationDuration: 0,
        percent:
            pvd.orderDetail!.orderStatusText! == 'ยกเลิก' ? 1 : percLoad / 100,
        progressColor: pvd.orderDetail!.orderStatusText! == 'ยกเลิก'
            ? Colors.red
            : Color(0xFF40C057),
      ),
    );
  }

  Widget statusDelievery(Widget widget, Color color, String text) {
    var constants = Constants();
    return Column(
      children: [
        circleBox(widget,
            bordercolor: // กรณีที่ถ้าส่งสีเทามาให้ใส่เป็นสีขาว เพราะ border เดี๋ยวจะเป็นสีเทา
                color == Color(0xFFA19F9F) ? Colors.white : color),
        SizedBox(
          width: 60,
          child: Center(
            child: constants.fontStyleRegular(text,
                fontSize: 18,
                colorValue: Color(0xFF7A7A7A),
                overflow: TextOverflow.visible),
          ),
        ),
      ],
    );
  }

  Widget circleBox(Widget widget, {Color? bordercolor, double? size}) {
    return Container(
      width: size ?? 60,
      height: size ?? 60,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(width: 3, color: bordercolor ?? Colors.white),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(1, 3),
            blurRadius: 2,
          ),
        ],
      ),
      child: Center(child: widget),
    );
  }

  Future<void> showBottomSheetGraphCard(BuildContext context) async {
    var constants = Constants();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: Constants.paddingAppLRTB,
          child: Container(
            height: 210,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<DetailDeliveryProvider>(
                builder: (context, pvd, child) => Column(
                  children: [
                    constants.fontStyleRegular('ติดต่อ',
                        fontSize: 22, colorValue: Color(0xFF3D525C)),
                    divider(),
                    Visibility(
                        visible: pvd.driverSts,
                        child: bottomcheetContactDetail(
                            'ไรเดอร์',
                            IconImport.ridercall,
                            pvd.driverSts
                                ? pvd.driverDetail!.driverPhone!
                                : '')),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: bottomcheetContactDetail('ร้านค้า',
                          IconImport.restcall, pvd.storeDetail!.phone!
                          // 'pvd.storeDetail![0].phone!'
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bottomcheetContactDetail(String header, IconData icon, String phone) {
    var constants = Constants();
    return Consumer3<DetailDeliveryProvider, AuthBloc, ChatArgumentProvider>(
      builder: (context, pvd, auth, chatArgumentProviderValue, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 35),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constants.fontStyleRegular(header,
                        fontSize: 20, colorValue: Color(0xFF3D525C)),
                    constants.fontStyleRegular(phone,
                        fontSize: 20, colorValue: Color(0xFF3D525C)),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              circleBox(
                  InkWell(
                      onTap: () => _makePhoneCall('tel:$phone'),
                      child: Icon(IconImport.phone,
                          size: 25, color: Color(0xFF40C057))),
                  size: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: circleBox(
                    header == 'ไรเดอร์'
                        ? InkWell(
                            onTap: () {
                              Constants().printColorCyan(
                                  '|| ${pvd.orderDetail!.customerId!.toString()}');

                              Constants()
                                  .printColorCyan('|| ${pvd.orderNumber}');

                              Constants().printColorCyan(
                                  '|| ${pvd.model!.result!.driverDetail!.first.id.toString()}');

                              List<String> noticData = [];

                              noticData.add('messages-customer-rider');
                              noticData.add(pvd
                                  .model!.result!.driverDetail!.first.id
                                  .toString());
                              noticData.add(pvd.orderNumber);
                              noticData
                                  .add(pvd.orderDetail!.customerId!.toString());

                              Provider.of<ChatArgumentProvider>(context,
                                      listen: false)
                                  .initFirebaseChat(noticData);

                              Navigator.pushNamed(context, '/chatRoom');
                            },
                            child: Badge(
                              badgeColor: const Color(0xffd42400),
                              showBadge: chatArgumentProviderValue
                                  .isHaveChatNoticCustomerRider,
                              //badgeContent: Text('3'),
                              position: BadgePosition.topEnd(top: -2, end: -2),
                              child: ClipOval(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    IconImport.messager,
                                    size: 25,
                                    color: Color(0xFFFEBC18),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Constants().printColorCyan(
                                  '|| ${pvd.model!.result!.storeDetail!.first.id.toString()}');

                              Constants()
                                  .printColorCyan('|| ${pvd.orderNumber}');

                              Constants().printColorCyan(
                                  '|| ${pvd.orderDetail!.customerId!.toString()}');

                              List<String> noticData = [];

                              noticData.add('messages-customer-restaurant');
                              noticData.add(pvd
                                  .model!.result!.storeDetail!.first.id
                                  .toString());
                              noticData.add(pvd.orderNumber);
                              noticData
                                  .add(pvd.orderDetail!.customerId!.toString());

                              Provider.of<ChatArgumentProvider>(context,
                                      listen: false)
                                  .initFirebaseChat(noticData);

                              Navigator.pushNamed(context, '/chatRoom');
                            },
                            child: Badge(
                              badgeColor: const Color(0xffd42400),
                              showBadge: chatArgumentProviderValue
                                  .isHaveChatNoticCustomerRestaurant,

                              //badgeContent: Text('3'),
                              position: BadgePosition.topEnd(top: -2, end: -2),
                              child: ClipOval(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    IconImport.messager,
                                    size: 25,
                                    color: Color(0xFFFEBC18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    size: 50),
              ),
            ],
          ),
        ],
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

  Widget spacing() {
    return Container(
      width: double.infinity,
      height: 20,
      color: Color(0xFFF3F3F3),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/screen/Fragment/MenuOrder/MenuOrderProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';
import '../FragmentProvider.dart';
import 'component/ReviewRiderAndRest.dart';

class MenuOrder extends StatefulWidget {
  @override
  _MenuOrder createState() => _MenuOrder();
}

class _MenuOrder extends State<MenuOrder> {
  @override
  void initState() {
    super.initState();

    Provider.of<MenuOrderProvider>(context, listen: false).initData(context);
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Scaffold(
        appBar: AppBar(
          title: constants.fontStyleBold('ออเดอร์', fontSize: 23),
          flexibleSpace: constants.flexibleSpaceInAppBar(),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Consumer2<MenuOrderProvider, FragmentProvider>(
          builder: (context, pvd, pvdFragment, child) => pvdFragment.stsSigin ==
                  false
              ? constants.fontStyleRegular('คุณยังไม่ได้ทำการ Login',
                  fontSize: 50, colorValue: Color(0xFFCECECE))
              : pvd.modelSuccess != null
                  ? constants.textNotSuccess(
                      context, pvd.modelSuccess!.result!.message!)
                  : pvd.listMenuOrder == null
                      ? constants.progressAPI()
                      : pvd.listMenuOrder!.length == 0
                          ? Text('')
                          : CustomScrollView(
                              slivers: [
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Padding(
                                    padding: Constants.paddingAppLRTB,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        pvd.listMenuOrder!.length,
                                        (index) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      const Color(0x29000000),
                                                  offset: Offset(1, 3),
                                                  blurRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                firstRowDetail(index, context),
                                                divider(),
                                                secondRowDetail(index),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
        )));
  }

  Widget secondRowDetail(int index) {
    var constants = Constants();
    return Consumer<MenuOrderProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        child: Column(
          children: [
            rowDetail(
              constants.fontStyleRegular(
                  '${constants.priceFormat(pvd.listMenuOrder![index].orderGrandTotal)} ฿',
                  fontSize: 20),
              constants.fontStyleRegular(
                  pvd.listMenuOrder![index].orderStatusText.toString(),
                  colorValue:
                      pvd.listMenuOrder![index].orderStatusText == 'ยกเลิก'
                          ? Colors.red
                          : Color(0xFF40C057),
                  fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  constants.fontStyleRegular(pvd.orderType(index),
                      fontSize: 18),
                  constants.fontStyleRegular(
                      pvd.listMenuOrder![index].orderDate,
                      fontSize: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstRowDetail(int index, BuildContext context) {
    var constants = Constants();
    return Consumer2<MenuOrderProvider, DetailDeliveryProvider>(
      builder: (context, pvd, pvdDeli, child) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => {
                pvdDeli.getDataByOrderList(
                  pvd.listMenuOrder![index].id!,
                ),
                Navigator.pushNamed(context, '/detailDelivery')
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.55,
                child: constants.fontStyleBold(
                    pvd.listMenuOrder![index].restaurantName.toString(),
                    fontSize: 24,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            pvd.listMenuOrder![index].orderStatusText == 'จัดส่งเรียบร้อย'
                ? checkStatusRarring(index)
                : followBuying(context, index)
          ],
        ),
      ),
    );
  }

  Widget rowDetail(Widget header, Widget value) {
    return Consumer<MenuOrderProvider>(
      builder: (context, pvd, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [header, value],
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: Color(0xFFE4E4E4),
      thickness: 1,
    );
  }

  Widget followBuying(context, index) {
    var constants = Constants();
    return Consumer2<MenuOrderProvider, DetailDeliveryProvider>(
      builder: (context, pvd, pvdDeli, child) => Visibility(
        visible: pvd.listMenuOrder![index].orderStatusText != 'ยกเลิก',
        child: InkWell(
          onTap: () => {
            pvdDeli.getDataByOrderList(pvd.listMenuOrder![index].id!),
            Navigator.pushNamed(context, '/detailDelivery')
          },
          child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: 35,
              color: Color(0xFF3D525C),
              child: Center(
                child: constants.fontStyleBold('ติดตามคำสั่งซื้อ',
                    fontSize: 18, colorValue: Colors.white),
              )),
        ),
      ),
    );
  }

  Widget checkStatusRarring(int index) {
    var constants = Constants();
    return Consumer<MenuOrderProvider>(
      builder: (context, pvd, child) => pvd.listMenuOrder![index].rating == 0 &&
              pvd.listMenuOrder![index].ratingDriver == 0
          ? !pvd.listMenuOrder![index].reviewStatus!
              ? Text('')
              : InkWell(
                  onTap: () {
                    pvd.clearRatingReview();
                    reviewRiderAndRest(context, index);
                    pvd.getOrderId(index);
                  },
                  child: constants.fontStyleRegular('เขียนรีวิว',
                      fontSize: 18, colorValue: Color(0xFF7A7A7A)),
                )
          : RatingBarIndicator(
              rating: double.parse(pvd.listMenuOrder![index].rating.toString()),
              itemSize: 12,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

Widget foodDiscount() {
  var constants = Constants();
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => Padding(
      padding: Constants.paddingAppLRTB,
      child: Visibility(
        visible: pvd.modelMenu!.result!.offersDiscount!.offerStatus!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: 30,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )))),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.01),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7575,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          constants.discountSvgIcon(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: constants.fontStyleBold(
                                                pvd
                                                            .modelMenu!
                                                            .result!
                                                            .offersDiscount!
                                                            .firstUser! ==
                                                        'Y'
                                                    ? "ส่วนลดสำหรับลูกค้าใหม่"
                                                    : "ส่วนลดสำหรับลูกค้า",
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Visibility(
                                        visible: pvd.modelMenu!.result!
                                                .offersDiscount!.firstUser! ==
                                            'Y',
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Color(0xFF3D525C),
                                          ),
                                          child: Center(
                                            child: constants.fontStyleRegular(
                                                "เฉพาะลูกค้าใหม่",
                                                fontSize: 18.5,
                                                colorValue: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  constants.fontStyleBold(
                                      "${pvd.modelMenu!.result!.offersDiscount!.offerPercentage}% Discount",
                                      fontSize: 50,
                                      colorValue: Colors.amber),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 3),
                                    child: constants.fontStyleRegular(
                                        pvd.modelMenu!.result!.offersDiscount!
                                                    .firstUser! ==
                                                'Y'
                                            ? "สำหรับลูกค้าใหม่"
                                            : ''
                                                "เมื่อสั่งซื้อขั้นต่ำ ${constants.priceFormat(pvd.modelMenu!.result!.offersDiscount!.offerMinPrice)} บาท ลดสูงสุด ${constants.priceFormat(pvd.modelMenu!.result!.offersDiscount!.offerMaxPrice)} บาท",
                                        fontSize: 22,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  constants.fontStyleRegular(
                                      'ใช้ได้ถึง ${pvd.modelMenu!.result!.offersDiscount!.offerTo!}',
                                      fontSize: 20.5,
                                      colorValue: Color(0xFF3D525C)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: 30,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  )))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                          height: 27,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(13),
                                    bottomRight: Radius.circular(13),
                                  )))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                          height: 27,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(13),
                                    bottomRight: Radius.circular(13),
                                  )))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

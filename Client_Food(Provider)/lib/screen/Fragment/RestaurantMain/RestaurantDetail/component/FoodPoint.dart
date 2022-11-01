import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

Widget foodPoint() {
  var constants = Constants();
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => Padding(
      padding: Constants.paddingAppLRTB,
      child: Visibility(
        visible: pvd.restDetails!.rewardOption!.toUpperCase() == 'YES',
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: constants.pointSvgIcon()),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          rowDetails('รับคะแนนสูงสุด',
                              '${pvd.restDetails!.rewardPoint} คะแนน'),
                          rowDetails('เมื่อสั่งซื้อสินค้าขั้นต่ำ',
                              '${constants.priceFormat(pvd.restDetails!.rewardMinBuy)} ฿'),
                          rowDetails('สามารถใช้เป็นลดสูงสุด',
                              '${constants.priceFormat(pvd.restDetails!.rewardMaxPrice)} ฿'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget rowDetails(String header, String value) {
  var constants = Constants();
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        constants.fontStyleRegular(header, fontSize: 20),
        constants.fontStyleBold(value, fontSize: 20, colorValue: Colors.amber)
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class CouponDiscount extends StatefulWidget {
  @override
  _CouponDiscount createState() => _CouponDiscount();
}

class _CouponDiscount extends State<CouponDiscount> {
  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Scaffold(
        appBar: AppBar(
            leading: constants.leadingBackIconAppBar(context),
            title: constants.fontStyleRegular('คูปองส่วนลด', fontSize: 21),
            flexibleSpace: constants.flexibleSpaceInAppBar()),
        body: Consumer<BasketPageProvider>(
          builder: (context, pvd, child) => pvd.voucherList == null
              ? constants.progressAPI()
              : SingleChildScrollView(
                  child: Padding(
                    padding: Constants.paddingAppLRT,
                    child: Column(
                      children: List.generate(
                        pvd.voucherList!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                          child: InkWell(
                            onTap: () {
                              pvd.onSelectCoupon(
                                  index: index,
                                  text: pvd.voucherList![index].voucherCode!,
                                  offerAmt: pvd.voucherList![index].offerValue,
                                  typeCoupon:
                                      pvd.voucherList![index].offerMode);

                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x29000000),
                                      offset: Offset(1, 3),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFFE4E4E4))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 35,
                                    child: Container(
                                      height: 120,
                                      color:
                                          pvd.voucherList![index].offerText! ==
                                                  'ส่งฟรี'
                                              ? Color(0xFFFEBC18)
                                              : Color(0xFFF60039),
                                      child: Center(
                                          child: constants.fontStyleBold(
                                              pvd.voucherList![index]
                                                  .offerText!,
                                              fontSize: 40,
                                              colorValue: Colors.white)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 65,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SizedBox(
                                        height: 100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            constants.textAutoNewLine(
                                              pvd.voucherList![index]
                                                  .voucherCode!,
                                              fontSize: 24.5,
                                            ),
                                            constants.textAutoNewLine(
                                                pvd.voucherList![index]
                                                    .offerDesc
                                                    .toString(),
                                                fontSize: 18.5,
                                                colorValue: Colors.green),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                constants.fontStyleRegular(
                                                    '*ใช้ได้ถึง ${pvd.voucherList![index].voucherTo!}',
                                                    fontSize: 18,
                                                    colorValue: Colors.red),
                                                ButtonAccept(
                                                  onPressed: () {
                                                    pvd.onSelectCoupon(
                                                        index: index,
                                                        text: pvd
                                                            .voucherList![index]
                                                            .voucherCode!,
                                                        offerAmt: pvd
                                                            .voucherList![index]
                                                            .offerValue,
                                                        typeCoupon: pvd
                                                            .voucherList![index]
                                                            .offerMode);

                                                    Navigator.pop(context);
                                                  },
                                                  text: 'ใช้คูปอง',
                                                  height: 35,
                                                  width: 65,
                                                  fontStyleRegular: false,
                                                  fontColor: Colors.white,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}

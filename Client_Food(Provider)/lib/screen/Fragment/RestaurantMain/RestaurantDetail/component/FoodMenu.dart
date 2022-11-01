import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:/model/FromJSON/MenuDetailsModel.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

Widget foodMenu(BuildContext context) {
  var constants = Constants();
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => LazyLoadScrollView(
      onEndOfPage: () {
        if (pvd.scrollLoading) {
          pvd.getLoadMenuAll(pvd.restIdScroll, context);
        }
      },
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          pvd.orderListAll == [] || pvd.orderListAll == null
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    constants.typeTabBar(context, 'เมนูแนะนำ'),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.02),
                      child: Wrap(
                        direction: Axis.horizontal,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: List.generate(
                          pvd.orderListAll!
                              .where((element) =>
                                  element.recommendMenuStatus == '1')
                              .length,
                          (index) => menuRecomentList(context,
                              menuId: pvd.orderListAll![index].id,
                              menuName: pvd.orderListAll![index].menuName,
                              price: pvd.orderListAll![index].menuPrice,
                              urlImg: pvd.orderListAll![index].menuImage,
                              description:
                                  pvd.orderListAll![index].menuDescription),
                        ),
                      ),
                    ),
                  ],
                ),
          pvd.orderListAll == [] || pvd.orderListAll == null
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(
                      bottom: pvd.stsbottomsheet
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.3),
                  child: Column(
                    children: List.generate(
                      pvd.orderListAll!
                          .where(
                              (element) => element.recommendMenuStatus == '0')
                          .length,
                      (index) => Column(
                        children: [
                          Visibility(
                              visible: pvd.checkcategoryName(
                                  pvd.getIndexMenuAll(index)),
                              child: constants.typeTabBar(
                                  context,
                                  pvd.orderListAll![pvd.getIndexMenuAll(index)]
                                          .categoryName ??
                                      '')),
                          Padding(
                              padding: Constants.paddingAppLRT,
                              child: foodListMenu(
                                context: context,
                                index: pvd.getIndexMenuAll(index),
                                orderListAll: pvd.orderListAll!,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
        ]),
      ),
    ),
  );
}

Widget menuRecomentList(BuildContext context,
    {String? menuId,
    String? menuName,
    String? price,
    String? urlImg,
    String? description}) {
  var constants = Constants();
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.width * 0.45,
              imageUrl: urlImg!,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => Center(
                child: CupertinoActivityIndicator(),
              ),
              errorWidget:
                  (BuildContext context, String pa, dynamic exception) {
                return Container(color: Colors.white, child: Text(''));
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 75,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: constants.fontStyleRegular(menuName!,
                              fontSize: 20, overflow: TextOverflow.ellipsis),
                        )),
                    Flexible(
                      flex: 25,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: buttonAdd(context, menuId!)),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      constants.fontStyleRegular(
                          '${constants.priceFormat(price)} ฿',
                          fontSize: 20),
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

Widget foodListMenu({
  required BuildContext context,
  required int index,
  required List<OrderListAll> orderListAll,
}) {
  var constants = Constants();
  return Consumer2<RestaurantDetailProvider, RestaurantDetailProvider>(
    builder: (context, pvd, pvdRestDetail, child) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 90,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: orderListAll[index].menuImage!,
                      memCacheHeight: 800,
                      memCacheWidth: 800,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget:
                          (BuildContext context, String pa, dynamic exception) {
                        return Container(color: Colors.white, child: Text(''));
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        constants.fontStyleBold(
                            orderListAll[index].menuName ?? '',
                            fontSize: 20),
                        constants.fontStyleBold(
                            '${constants.priceFormat(orderListAll[index].menuPrice)} ฿',
                            fontSize: 24,
                            colorValue: Color(0xFFFEBC18)),
                        constants.textAutoNewLine(
                            orderListAll[index].menuDescription!,
                            fontSize: 18,
                            colorValue: Color(0xFF3D525C)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: buttonplus(context, orderListAll[index].id!),
            ),
          ],
        ),
        divider(),
      ],
    ),
  );
}

Widget buttonAdd(context, String menuId) {
  var constants = Constants();
  return Consumer2<BasketPageProvider, RestaurantDetailProvider>(
    builder: (context, pvdBasket, pvd, child) => InkWell(
      onTap: () {
        pvdBasket.intitdataProd(menuId);
        Navigator.pushNamed(context, '/selectNumFoodOrder');
      },
      child: Container(
          height: 30,
          width: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFFEBC18),
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(1, 3),
                blurRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: constants.fontStyleBold('เพิ่ม',
                fontSize: 18, colorValue: Colors.white),
          )),
    ),
  );
}

Widget buttonplus(context, String menuId) {
  return Consumer2<BasketPageProvider, RestaurantDetailProvider>(
      builder: (context, pvdBasket, pvd, child) => InkWell(
            onTap: () {
              pvdBasket.intitdataProd(menuId);
              Navigator.pushNamed(context, '/selectNumFoodOrder');
            },
            child: Icon(
              Icons.add_circle_outline,
              color: const Color(0xFFFEBC18),
            ),
          ));
}

Widget divider() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
    child: Divider(
      color: const Color(0x90FEBC18),
      thickness: 1,
    ),
  );
}

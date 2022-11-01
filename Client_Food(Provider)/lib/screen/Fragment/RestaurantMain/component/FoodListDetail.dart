import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:/model/FromJSON/SearchesModel.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/utils/icon/IconImport.dart';

Widget foodListDetail(
    BuildContext context, List<RestaurantLists> listDetail, String flagPage) {
  return Consumer2<RestaurantMainProvider, RestaurantDetailProvider>(
    builder: (context, pvd, pvdRestDetail, child) => Wrap(
      children: List.generate(
        listDetail.length,
        (index) => InkWell(
          onTap: () {
            if (listDetail[index].currentStatus! == 'Open') {
              pvdRestDetail.getRestaurantDetail(
                  listDetail[index].id.toString(), context);

              Navigator.pushNamed(context, '/restaurantDetail');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Column(
                children: [
                  Stack(
                    children: [
                      imageOrder(context, listDetail, index),
                      closeRest(listDetail, index, context),
                      couponAndHeath(listDetail, index, context, pvd, flagPage),
                    ],
                  ),
                  restDescription(context, listDetail, index),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget restDescription(
    BuildContext context, List<RestaurantLists> listDetail, int index) {
  var constants = Constants();
  return FittedBox(
    fit: BoxFit.fitWidth,
    child: Padding(
      padding: const EdgeInsets.only(left: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constants.fontStyleRegular(listDetail[index].restaurantName!,
                overflow: TextOverflow.ellipsis, fontSize: 26.5),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 8),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listDetail[index].listCuisine.length,
                  itemBuilder: (context, index2) => Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: constants.fontStyleRegular(
                            '   ${listDetail[index].listCuisine[index2]}   ',
                            fontSize: 22,
                            colorValue: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: listDetail[index].promotionTitle! == '' ? false : true,
              child: constants.textAutoNewLine(
                  listDetail[index].promotionTitle!,
                  fontSize: 24,
                  colorValue: Color(0xFFFEBC18)),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget couponAndHeath(List<RestaurantLists> listDetail, int index,
    BuildContext context, RestaurantMainProvider pvd, String flagPage) {
  var constants = Constants();
  return Visibility(
    visible: listDetail[index].currentStatus! == 'Open' && pvd.loginSts,
    child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
              visible: listDetail[index].promotionTitle == '' ? false : true,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.095,
                height: MediaQuery.of(context).size.width * 0.095,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: constants.couponMainPageSvgIcon(),
              )),
          InkWell(
            onTap: () => pvd.changeStatusfavourite(index, flagPage),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.095,
              height: MediaQuery.of(context).size.width * 0.095,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: listDetail[index].favourite! == '1'
                    ? Color(0xFFF02756)
                    : Colors.white,
              ),
              child: listDetail[index].favourite! == '1'
                  ? Icon(
                      IconImport.heart,
                      size: 20,
                      color: Colors.white,
                    )
                  : Icon(
                      IconImport.heart_empty,
                      size: 20,
                      color: Color(0xFFBBBBBB),
                    ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget closeRest(
    List<RestaurantLists> listDetail, int index, BuildContext context) {
  var constants = Constants();
  return Visibility(
    visible: listDetail[index].currentStatus! == 'Open' ? false : true,
    child: Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(0, 0, 0, 0.5),
      ),
      child: Center(
          child: constants.fontStyleRegular('ปิด',
              fontSize: 25, colorValue: Colors.white)),
    ),
  );
}

Widget imageOrder(
    BuildContext context, List<RestaurantLists> listDetail, int index) {
  return SizedBox(
    height: MediaQuery.of(context).size.width * 0.45,
    width: MediaQuery.of(context).size.width * 0.45,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CupertinoActivityIndicator(),
        ),
        errorWidget: (BuildContext context, String pa, dynamic exception) {
          return Material(color: Colors.white, child: Text(''));
        },
        imageUrl: listDetail[index].restaurantLogo.toString(),
        fit: BoxFit.cover,
      ),
    ),
  );
}

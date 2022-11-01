import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';

Widget searchBar(BuildContext context) {
  var constants = Constants();
  return Consumer<RestaurantMainProvider>(
    builder: (context, pvd, child) => Padding(
      padding: Constants.paddingAppLR,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 10.0,
            left: MediaQuery.of(context).size.width * 0.0125,
            right: MediaQuery.of(context).size.width * 0.0125),
        child: InkWell(
          onTap: () => pvd.onClickSearchBar(context),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  constants.fontStyleRegular('ค้นหา',
                      fontSize: 20, colorValue: Color(0xFF888888)),
                  Icon(IconImport.searchbar, color: Color(0xFF3D525C), size: 21)
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

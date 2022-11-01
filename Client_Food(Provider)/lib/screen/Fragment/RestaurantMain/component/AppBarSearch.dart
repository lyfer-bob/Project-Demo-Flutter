import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:provider/provider.dart';
import '../../../../utils/Constants.dart';

AppBar appBarSearch(BuildContext context) {
  var constants = Constants();
  return AppBar(
    flexibleSpace: constants.flexibleSpaceInAppBar(),
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Consumer2<RestaurantMainProvider, AddressSavePageProvider>(
      builder: (context, pvd, pvdaddres, child) => pvdaddres
                  .showAddress.title ==
              ''
          ? Text('')
          : Padding(
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
                    controller: pvd.fname,
                    autocorrect: true,
                    autofocus: true,
                    onChanged: (newValue) {
                      if (newValue == '') {
                        pvd.clearTabSearch(context);
                      } else {
                        pvd.getDataListMenuMain(
                            searchText: newValue,
                            flagPage: 'Search',
                            context: context);
                      }
                    },
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                        fontFamily: 'THSarabun',
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: InkWell(
                          onTap: () => pvd.closeTabSearch(context),
                          child: Icon(Icons.arrow_back, color: Colors.black26)),
                      suffixIcon: InkWell(
                          onTap: () => pvd.clearTabSearch(context),
                          child: Icon(Icons.close, color: Colors.black26)),
                      hintText: 'ค้นหาร้านอาหาร',
                      hintStyle: TextStyle(
                          fontFamily: 'THSarabun',
                          fontSize: 21,
                          color: Color(0xff737373),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ),
    ),
  );
}

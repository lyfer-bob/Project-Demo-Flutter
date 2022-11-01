import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/screen/Profile/Address/AddressSavePageProvider.dart';
import 'package:/screen/Profile/provider/ProfileCustomerProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/FoodListDetail.dart';
import 'component/SearchBar.dart';
import 'component/AppBarMain.dart';
import 'component/BannerSlide.dart';

class RestaurantMain extends StatefulWidget {
  @override
  _RestaurantMain createState() => _RestaurantMain();
}

class _RestaurantMain extends State<RestaurantMain> {
  int crossAxisCount = 4;

  String? avatorphotoURL;

  @override
  void initState() {
    super.initState();

    Provider.of<RestaurantMainProvider>(context, listen: false)
        .intitMainPage(context: context);

    Provider.of<ProfileCustomerProvider>(context, listen: false)
        .initData(context);

    _getPreferences();
  }

  _getPreferences() async {
    var preferences = await SharedPreferences.getInstance();

    avatorphotoURL = preferences.getString('avatorImg');
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Consumer<RestaurantMainProvider>(
      builder: (context, pvd, child) => Scaffold(
        appBar: appBarMain(context, photoURL: avatorphotoURL),
        body: Consumer2<RestaurantMainProvider, AddressSavePageProvider>(
            builder: (context, pvd, pvdAddress, child) => pvd.modelSuccess !=
                    null
                ? constants.textNotSuccess(
                    context, pvd.modelSuccess!.result!.message!)
                : pvd.model == null && pvd.maxScorolLoadMain
                    ? constants.progressAPI()
                    : LazyLoadScrollView(
                        onEndOfPage: () => pvd.isScorolLoadMain
                            ? pvd.scorllLoading('MainFlagment', context)
                            : null,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150,
                                      color: Color(0xFF3D525C),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      searchBar(context),
                                      bannerSlide(context),
                                    ],
                                  ),
                                ],
                              ),
                              categoryList(),
                              divider(),
                              Padding(
                                padding: Constants.paddingAppLRTB,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    constants.fontStyleBold('ร้านอาหารใกล้ฉัน',
                                        fontSize: 22),
                                    InkWell(
                                        onTap: () => pvd.refrestData(context),
                                        child: Icon(Icons.refresh_outlined))
                                  ],
                                ),
                              ),
                              pvd.listRestDetail.length == 0
                                  ? Center(
                                      child: constants.fontStyleRegular(
                                          'ไม่พบร้านอาหารใกล้ฉัน',
                                          fontSize: 50,
                                          overflow: TextOverflow.ellipsis,
                                          colorValue: Color(0xFFCECECE)))
                                  : foodListDetail(context, pvd.listRestDetail,
                                      'MainFlagment'),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 18),
                                child: Visibility(
                                  visible: !pvd.isScorolLoadMain &&
                                      !pvd.maxScorolLoadMain,
                                  child: CupertinoActivityIndicator(
                                    radius: 22.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
      ),
    );
  }

  Widget categoryList() {
    var constants = Constants();
    return Consumer<RestaurantMainProvider>(
      builder: (context, pvd, child) => Padding(
        padding: Constants.paddingAppLR,
        child: Visibility(
          visible: pvd.allCuisinesLists.length > 1,
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pvd.allCuisinesLists.length,
              itemBuilder: (context, index) => Visibility(
                visible: pvd.allCuisinesLists[index].iconImg != '' ||
                    pvd.allCuisinesLists[index].name == 'ดูทั้งหมด',
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () {
                          if (pvd.allCuisinesLists[index].name == 'ดูทั้งหมด') {
                            pvd.changePageCategorySts(true);
                            Navigator.pushNamed(context, '/allCategory');
                          } else
                            pvd.onClickFoodType(
                                context,
                                pvd.allCuisinesLists[index].name.toString(),
                                pvd.allCuisinesLists[index].id.toString());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(pvd.colorCategory(index))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  pvd.allCuisinesLists[index].name ==
                                          'ดูทั้งหมด'
                                      ? Icon(Icons.add)
                                      : SvgPicture.string(
                                          '''${utf8.decode(base64.decode(pvd.allCuisinesLists[index].iconImg!))}'''),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: constants.fontStyleBold(
                                        pvd.allCuisinesLists[index].name!,
                                        fontSize: 18,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 7, bottom: 7, right: 5),
      child: Divider(
        color: Color(0xFFE4E4E4),
        thickness: 10,
      ),
    );
  }
}

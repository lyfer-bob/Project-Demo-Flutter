import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/component/BannerSlide.dart';
import 'package:/screen/Fragment/RestaurantMain/component/FoodListDetail.dart';
import 'package:/screen/Fragment/RestaurantMain/component/AppBarMain.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectTypeFood extends StatefulWidget {
  @override
  _SelectTypeFood createState() => _SelectTypeFood();
}

class _SelectTypeFood extends State<SelectTypeFood> {
  String? avatorphotoURL;

  @override
  void initState() {
    super.initState();
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
        body: Consumer<RestaurantMainProvider>(
          builder: (context, pvd, child) => pvd.modelSuccess != null
              ? constants.textNotSuccess(
                  context, pvd.modelSuccess!.result!.message!)
              : pvd.model == null && pvd.maxScorolLoadType
                  ? constants.progressAPI()
                  : LazyLoadScrollView(
                      onEndOfPage: () => pvd.isScorolLoadType
                          ? pvd.scorllLoading('TypeFood', context)
                          : null,
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 120,
                                        color: Color(0xFF3D525C),
                                      ),
                                    ),
                                    bannerSlide(context),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    color: Color(0xFFF3F3F3),
                                    child: Row(
                                      children: [
                                        constants.leadingBackIconAppBar(context,
                                            onPressed: () {
                                          pvd.intitMainPage(context: context);

                                          Navigator.pop(context);
                                        }),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: constants.fontStyleRegular(
                                              pvd.foodType,
                                              fontSize: 22.00),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                !pvd.checkData
                                    ? Center(
                                        child: constants.fontStyleRegular(
                                            'ไม่พบข้อมูล',
                                            fontSize: 50,
                                            colorValue: Color(0xFFCECECE)))
                                    : Column(
                                        children: [
                                          foodListDetail(
                                              context,
                                              pvd.listRestDetailType,
                                              'TypeFood'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 18),
                                            child: Visibility(
                                              visible: !pvd.isScorolLoadType &&
                                                  !pvd.maxScorolLoadType,
                                              child: CupertinoActivityIndicator(
                                                radius: 22.5,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/component/AppBarSearch.dart';
import 'package:/screen/Fragment/RestaurantMain/component/FoodListDetail.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Consumer<RestaurantMainProvider>(
      builder: (context, pvd, child) => WillPopScope(
        onWillPop: () {
          pvd.closeTabSearch(context);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: appBarSearch(context),
          body: Consumer<RestaurantMainProvider>(
            builder: (context, pvd, child) => pvd.modelSuccess != null
                ? constants.textNotSuccess(
                    context, pvd.modelSuccess!.result!.message!)
                : pvd.model == null && pvd.maxScorolLoadSearch
                    ? constants.progressAPI()
                    : !pvd.checkData
                        ? Center(
                            child: constants.fontStyleRegular('ไม่พบข้อมูล',
                                fontSize: 80, colorValue: Color(0xFFCECECE)))
                        : LazyLoadScrollView(
                            onEndOfPage: () => pvd.isScorolLoadSearch &&
                                    pvd.fname.text.trim() != ''
                                ? pvd.scorllLoading('Search', context)
                                : null,
                            child: CustomScrollView(
                              slivers: [
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                    children: [
                                      foodListDetail(context,
                                          pvd.listRestDetailSearch, 'Search'),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 18),
                                        child: Visibility(
                                          visible: !pvd.isScorolLoadSearch &&
                                              !pvd.maxScorolLoadSearch,
                                          child: CupertinoActivityIndicator(
                                            radius: 22.5,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
          ),
        ),
      ),
    );
  }
}

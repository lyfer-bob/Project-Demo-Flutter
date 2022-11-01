import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:/screen/Fragment/BasketPage/BasketPageProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';
import '../../FragmentProvider.dart';
import 'component/FoodDetail.dart';
import 'component/FoodDiscount.dart';
import 'component/FoodMenu.dart';
import 'component/FoodPoint.dart';
import 'component/FoodReview.dart';

class RestaurantDetail extends StatefulWidget {
  @override
  _RestaurantDetail createState() => _RestaurantDetail();
}

class _RestaurantDetail extends State<RestaurantDetail>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    Provider.of<BasketPageProvider>(context, listen: false)
        .listSubAdddonList
        .clear();
    _tabController = new TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Consumer2<RestaurantDetailProvider, FragmentProvider>(
      builder: (context, pvd, pvdFrag, child) => WillPopScope(
        onWillPop: () {
          pvdFrag.changeIndexpage(0);
          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            flexibleSpace: constants.flexibleSpaceInAppBar(),
            leading: pvd.restDetails == null
                ? Text('')
                : constants.leadingBackIconAppBarNew(context, onPressed: () {
                    pvdFrag.changeIndexpage(0);

                    Navigator.pop(context);
                  }),
          ),
          body: Consumer<RestaurantDetailProvider>(
            builder: (context, pvd, child) => pvd.restDetails == null
                ? Constants().progressAPI()
                : Container(
                    child: CustomScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          foodDetailHeader(context),
                                          tabBar(context),
                                        ],
                                      )
                                    ])
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          bottomSheet: bottomSheet(),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    var constants = Constants();
    return Consumer3<RestaurantDetailProvider, FragmentProvider,
        BasketPageProvider>(
      builder: (context, pvd, pvdFragment, pvdBaskeet, child) => Visibility(
        visible: pvdBaskeet.sumNumOrderProd == 0 ? false : pvd.stsbottomsheet,
        child: InkWell(
          onTap: () {
            pvdBaskeet.checkInitPageby('byBottomSheet');
            pvdFragment.openBasketPage(context);
          },
          child: Container(
            color: Color(0xFFFEBC18),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.065,
            child: Padding(
              padding: Constants.paddingAppLRTB,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          constants.fontStyleBold(
                              '${constants.priceFormat(pvdBaskeet.sumNumOrderProd)} รายการอาหาร | ${constants.priceFormat(pvdBaskeet.sumPriceTotal)} ฿ ',
                              fontSize: 30,
                              colorValue: Colors.white),
                        ],
                      ),
                      Row(
                        children: [
                          constants.fontStyleBold('ดูตะกร้า  ',
                              fontSize: 30, colorValue: Colors.white),
                          Icon(
                            IconImport.basketicon,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: Constants.paddingAppLR,
          child: Container(
            height: 35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black12),
            child: TabBar(
              tabs: [
                menuTabBar('เมนู'),
                menuTabBar('ข้อมูล'),
                menuTabBar('ส่วนลด'),
                menuTabBar('คะแนน'),
                menuTabBar('รีวิว'),
              ],
              overlayColor: MaterialStateProperty.all(Color(0xFFFEBC18)),
              indicatorColor: Color(0xFFFEBC18),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFFEBC18)),
              // indicatorPadding: EdgeInsets.all(2),
              isScrollable: false,
              controller: _tabController,
            ),
          ),
        ),
        divider(),
        Container(
          height: 500,
          child: TabBarView(controller: _tabController, children: <Widget>[
            foodMenu(context),
            foodDetail(),
            foodDiscount(),
            foodPoint(),
            foodReview(),
          ]),
        )
      ],
    );
  }

  Widget foodDetailHeader(BuildContext context) {
    var constants = Constants();
    return Consumer2<RestaurantDetailProvider, RestaurantMainProvider>(
      builder: (context, pvd, pvdMain, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Constants.paddingAppLR,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                constants.fontStyleBold(
                    pvd.restDetails!.restaurantName.toString(),
                    fontSize: 30),
                constants.fontStyleRegular(
                    pvd.restDetails!.cuisineLists.toString(),
                    fontSize: 18,
                    colorValue: Color(0xFF3D525C)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.5, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star_purple500_outlined,
                      color: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: constants.fontStyleBold(
                          pvd.restDetails!.finalReview!.toStringAsFixed(1),
                          fontSize: 18,
                          colorValue: Color(0xFF3D525C)),
                    ),
                  ],
                ),
                pvd.restDetails!.favourite == 1
                    ? InkWell(
                        onTap: () => {
                          pvdMain.getDataListMenuMain(
                              flagPage: 'MainFlagment', context: context),
                          pvd.changeStatusfavourite(),
                        },
                        child: Icon(
                          IconImport.heart,
                          color: Colors.red,
                          size: 16,
                        ),
                      )
                    : InkWell(
                        onTap: () => {
                          pvdMain.getDataListMenuMain(
                              flagPage: 'MainFlagment', context: context),
                          pvd.changeStatusfavourite(),
                        },
                        child: Icon(
                          IconImport.heart_empty,
                          size: 16,
                        ),
                      ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: CachedNetworkImage(
                errorWidget:
                    (BuildContext context, String pa, dynamic exception) {
                  return Container(color: Colors.white, child: Text(''));
                },
                imageUrl: pvd.restDetails!.logoName.toString(),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: Constants.paddingAppLRTB,
            child: Column(
              children: [
                Row(
                  children: [
                    foodDetailBar(
                        'ยอดขั้นต่ำ',
                        '${constants.priceFormat(pvd.restDetails!.minimumOrder.toString())} ฿',
                        30),
                    foodDetailBar('ระยะทาง',
                        '${pvd.restDetails!.distance.toString()} Km.', 30),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuTabBar(String text) {
    var constants = Constants();
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: FittedBox(
              child: constants.fontStyleBold(text,
                  fontSize: 18, overflow: TextOverflow.visible),
            ),
          ),
        ],
      ),
    );
  }

  Widget foodDetailBar(String value, String header, int size) {
    var constants = Constants();
    return Expanded(
      flex: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          constants.fontStyleBold(value, fontSize: 17),
          constants.fontStyleBold(header,
              fontSize: 25, colorValue: Colors.amber),
        ],
      ),
    );
  }

  Widget dotText(Constants constants) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: constants.fontStyleRegular('   .  '),
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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:/screen/AboutUs/Notification/AllNotic.dart';
import 'package:/screen/AboutUs/Notification/OrderNotic.dart';
import 'package:/screen/AboutUs/Notification/PromotionNoticPage.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/FragmentProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

class ShowNoticPage extends StatefulWidget {
  @override
  _ShowNoticPageState createState() => _ShowNoticPageState();
}

class _ShowNoticPageState extends State<ShowNoticPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        Provider.of<GlobalURLProvider>(context, listen: false)
            .getNotiData('AllNoti');
      } else if (_tabController.index == 1) {
        Provider.of<GlobalURLProvider>(context, listen: false)
            .getNotiData('Order');
      } else if (_tabController.index == 2) {
        Provider.of<GlobalURLProvider>(context, listen: false)
            .getNotiData('NewsAndProm');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Consumer<FragmentProvider>(
        builder: (context, pvdFrag, child) {
          var constants = Constants();
          return Scaffold(
            appBar: AppBar(
              leading: pvdFrag.currentIndex == 4
                  ? constants.leadingBackIconAppBar(context)
                  : null,
              bottom: PreferredSize(
                preferredSize: Size(
                  MediaQuery.of(context).size.width,
                  pvdFrag.stsSigin ? 70.0 : 0,
                ),
                child: Consumer2<GlobalURLProvider, FragmentProvider>(
                  builder: (context, pvd, pvdFlag, child) => Visibility(
                    visible: pvdFlag.stsSigin,
                    child: Column(children: [
                      Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TabBar(
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xfffebc18),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          tabs: [
                            Tab(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Constants().fontStyleRegular(
                                    'ทั้งหมด',
                                    fontSize: 20,
                                    colorValue: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Constants().fontStyleRegular(
                                    'รายการคำสั่งซื้อ',
                                    fontSize: 20,
                                    colorValue: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.33,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Constants().fontStyleRegular(
                                    'ข่าวสาร/โปรโมชั่น',
                                    fontSize: 20,
                                    colorValue: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              title: Constants().fontStyleBold(
                'การแจ้งเตือน',
                fontSize: pvdFrag.currentIndex == 4 ? 21 : 23,
                colorValue: Colors.black,
              ),
              iconTheme: IconThemeData(
                color: Color(0xFF3D525C), //change your color here
              ),
              shadowColor: Color(0x29000000),
            ),
            body: Consumer<FragmentProvider>(
              builder: (context, pvd, child) => !pvd.stsSigin
                  ? Center(
                      child: Constants().fontStyleRegular(
                          'คุณยังไม่ได้ทำการ Login',
                          fontSize: 50,
                          colorValue: Color(0xFFCECECE)),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        ShowAllNoticPage(),
                        OrderNoticPage(),
                        PromotionNoticPage(),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}

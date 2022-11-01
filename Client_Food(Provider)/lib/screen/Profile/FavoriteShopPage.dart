import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/screen/Profile/provider/FavoriteShopProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/icon/IconImport.dart';
import 'package:provider/provider.dart';

class FavoriteShopPage extends StatefulWidget {
  const FavoriteShopPage({Key? key}) : super(key: key);

  @override
  _FavoriteShopPageState createState() => _FavoriteShopPageState();
}

class _FavoriteShopPageState extends State<FavoriteShopPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavoriteShopProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    var constants = Constants();
    return Scaffold(
      appBar: AppBar(
        leading: Constants().leadingBackIconAppBar(context),
        centerTitle: false,
        title: Constants().fontStyleBold('ร้านค้าที่ถูกใจ', fontSize: 21),
        flexibleSpace: Constants().flexibleSpaceInAppBar(),
      ),
      body: Consumer<FavoriteShopProvider>(
        builder: (context, pvd, child) => pvd.listRes == null
            ? constants.progressAPI()
            : pvd.listRes!.length == 0
                ? Center(
                    child:
                        Constants().fontStyleBold('ไม่พบข้อมูล', fontSize: 21))
                : Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  pvd.listRes!.length,
                                  (index) => foodListDetail(index, context),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget foodListDetail(int index, BuildContext context) {
    var constants = Constants();
    return Consumer2<FavoriteShopProvider, RestaurantDetailProvider>(
      builder: (context, pvd, pvdRestDetail, child) => Column(
        children: [
          InkWell(
            onTap: () {
              if (pvd.listRes![index].currentStatus! == 'Open') {
                pvdRestDetail.getRestaurantDetail(
                    pvd.listRes![index].id.toString(), context);

                Navigator.pushNamed(context, '/restaurantDetail');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          '${pvd.listRes![index].restaurantLogo}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: pvd.listRes![index].currentStatus! == 'Open'
                          ? false
                          : true,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: Center(
                            child: constants.fontStyleRegular('ปิด',
                                fontSize: 22, colorValue: Colors.white)),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Stack(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constants.fontStyleBold(
                                  pvd.listRes![index].restaurantName.toString(),
                                  fontSize: 22),
                              constants.fontStyleBold(
                                  pvd.listRes![index].cuisineLists.toString(),
                                  fontSize: 18,
                                  colorValue: Color(0xFF3D525C)),
                              Visibility(
                                visible:
                                    pvd.listRes![index].promotionTitle! != '',
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: constants.textAutoNewLine(
                                      pvd.listRes![index].promotionTitle!,
                                      fontSize: 18,
                                      colorValue: Color(0xFFFEBC18)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: DottedLine(
                                  direction: Axis.horizontal,
                                  lineLength: double.infinity,
                                  lineThickness: 1.0,
                                  dashLength: 4.0,
                                  dashColor: Color(0xFFE4E4E4),
                                  dashRadius: 0.0,
                                  dashGapLength: 4.0,
                                  dashGapColor: Colors.transparent,
                                  dashGapRadius: 0.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 5, top: 25),
                                child: Visibility(
                                    visible:
                                        pvd.listRes![index].promotionTitle !=
                                            '',
                                    child: Icon(
                                      IconImport.ticketicon,
                                      color: Colors.blue,
                                      size: 20,
                                    )),
                              ),
                              InkWell(
                                onTap: () => pvd.changeStatusfavourite(index),
                                child: Icon(
                                  IconImport.heart,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          divider(),
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
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
      child: Divider(
        color: Color(0xFFE4E4E4),
        thickness: 1,
      ),
    );
  }
}

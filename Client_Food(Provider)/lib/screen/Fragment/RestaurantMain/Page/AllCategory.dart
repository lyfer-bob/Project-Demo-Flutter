import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:/screen/Fragment/RestaurantMain/component/SearchBar.dart';
import 'package:/screen/Fragment/RestaurantMain/component/AppBarMain.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantMainProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

final rnd = Random();
final List<int> extents =
    List<int>.generate(100, (int index) => rnd.nextInt(4));

//final List heightExtents = [175, 210, 175, 210];
final List heightExtents = [175, 200, 175, 200];

class AllCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var constants = new Constants();
    return Consumer<RestaurantMainProvider>(
      builder: (context, pvd, child) => WillPopScope(
        onWillPop: () {
          pvd.changePageCategorySts(false);

          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: appBarMain(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                      height: 100,
                      color: Color(0xFF3D525C),
                    ),
                  ),
                  searchBar(context),
                ],
              ),
              Padding(
                padding: Constants.paddingAppLRTB,
                child: constants.fontStyleBold('ประเภทร้านอาหาร', fontSize: 24),
              ),
              Flexible(
                child: thumbnailGridView(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget thumbnailGridView(BuildContext context) {
  return Consumer<RestaurantMainProvider>(
    builder: (context, pvd, child) => Padding(
      padding: Constants.paddingAppLR,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: MasonryGridView.count(
          //  physics: NeverScrollableScrollPhysics(),
          crossAxisCount: (MediaQuery.of(context).size.width / 178).floor(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            Random random = new Random();
            int randomNumber = random.nextInt(2);

            // print(extents[index]);

            // print(heightExtents[extents[index]]);

            index == pvd.allCuisinesLists.length - 1
                ? randomNumber = 212
                : randomNumber =
                    heightExtents[extents[index]]; //extents[index];

            return Container(
              width: 178,
              height: randomNumber.toDouble(),
              //color: Colors.teal[100 * (index % 9)],
              child: listMenu(
                context,
                pvd.allCuisinesLists[index].urlImg!,
                pvd.allCuisinesLists[index].id.toString(),
                pvd.allCuisinesLists[index].name!,
                randomNumber.toDouble(),
              ),
            );
          },
          itemCount: pvd.allCuisinesLists.length - 1,
        ),
      ),
    ),
  );
}

Widget listMenu(BuildContext context, String imageName, String cuisinesID,
    cuisinesName, double imgHeight) {
  var constants = Constants();
  return Consumer<RestaurantMainProvider>(
    builder: (context, pvd, child) => InkWell(
      onTap: () => pvd.onClickFoodType(context, cuisinesName, cuisinesID),
      child: Container(
        width: 158,
        height: imgHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(17),
              ),
              child: Container(
                width: 158,
                height: imgHeight - 35,
                color: Colors.grey.shade300,
                child: CachedNetworkImage(
                  errorWidget:
                      (BuildContext context, String pa, dynamic exception) {
                    return Container(color: Colors.white, child: Text(''));
                  },
                  imageUrl: imageName,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            // SizedBox(
            //   width: 178,
            //   height: imgHeight - 35,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(17),
            //     child: CachedNetworkImage(
            //       errorWidget:
            //           (BuildContext context, String pa, dynamic exception) {
            //         return Container(color: Colors.white, child: Text(''));
            //       },
            //       imageUrl: imageName,
            //       fit: BoxFit.fitWidth,
            //     ),
            //   ),
            // ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: constants.fontStyleBold(' $cuisinesName',
                    fontSize: 21, overflow: TextOverflow.ellipsis),
              ),
            ),
            // Padding(
          ],
        ),
      ),
    ),
  );
}

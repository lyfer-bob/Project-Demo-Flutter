import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:/screen/Fragment/MenuOrder/MenuOrderProvider.dart';
import 'package:/utils/ButtonAccept.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

Future<Null> reviewRiderAndRest(BuildContext context, index) async {
  var constants = new Constants();

  showDialog(
    context: context,
    builder: (context) => Consumer<MenuOrderProvider>(
      builder: (context, pvd, child) => SimpleDialog(
        insetPadding: Constants.paddingAppLRTB,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: Constants.paddingAppLRT,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: pvd.listMenuOrder![index].driverName == null
                          ? false
                          : true,
                      child: Column(
                        children: [
                          rowDetail(
                              header: 'ให้คะแนนคนขับ',
                              imgpart: pvd.listMenuOrder![index].driverImg,
                              name: pvd.listMenuOrder![index].driverName,
                              star: pvd.orderReview.driverRating,
                              flag: 'rider'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Divider(
                              color: Color(0xFFE4E4E4),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    rowDetail(
                        header: 'ให้คะแนนร้านค้า',
                        imgpart: pvd.listMenuOrder![index].restaurantLogo,
                        name: pvd.listMenuOrder![index].restaurantName,
                        star: pvd.orderReview.rating,
                        flag: 'rest'),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: constants.fontStyleRegular('เขียนรีวิวร้านค้า',
                          fontSize: 21),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black12,
                            width: 0.45,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  controller: pvd.messageCont,
                                  autofocus: true,
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      fontFamily: 'THSarabun',
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                  maxLines: 3,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'ความคิดเห็น',
                                      hintStyle: TextStyle(
                                          fontFamily: 'THSarabun',
                                          fontSize: 21,
                                          color: Color(0xff737373),
                                          fontWeight: FontWeight.normal)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15.0),
                      child: ButtonAccept(
                        onPressed: () => pvd.submitRating(context),
                        text: 'ให้คะแนน',
                        fontColor: Colors.white,
                        backgroundColor: Color(0xFFFEBC18),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,
                      ),
                    ),
                    ButtonAccept(
                      onPressed: () => Navigator.pop(context),
                      text: 'ยกเลิก',
                      backgroundColor: Color(0xFFDADADA),
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget rowDetail(
    {String? header,
    String? name,
    double? star,
    String? imgpart,
    String? flag}) {
  var constants = Constants();
  return Consumer<MenuOrderProvider>(
    builder: (context, pvd, child) => Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            constants.fontStyleRegular(header!, fontSize: 21),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: CachedNetworkImage(
                          imageUrl: imgpart!, fit: BoxFit.fill),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: constants.fontStyleRegular(name!, fontSize: 18),
                  ),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.79,
                child: RatingBar.builder(
                  itemSize: 45,
                  initialRating: star!,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.3),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    flag == 'rider'
                        ? pvd.onChangeRiderRatting(rating)
                        : pvd.onChangeRestRatting(rating);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

Widget foodReview() {
  var constants = Constants();
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => SingleChildScrollView(
      child: Column(children: [
        pvd.restDetails!.reviews == []
            ? Text('')
            : Padding(
                padding: EdgeInsets.only(
                    bottom: pvd.stsbottomsheet
                        ? MediaQuery.of(context).size.height * 0.195
                        : MediaQuery.of(context).size.height * 0.125),
                child: Column(
                  children: List.generate(
                    pvd.restDetails!.reviews!.length,
                    (index) => Padding(
                      padding: Constants.paddingAppLR,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              constants.fontStyleBold(
                                '${pvd.restDetails!.reviews?[index].user?.fullname}',
                                fontSize: 21,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_purple500_outlined,
                                    color: Colors.amber,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: constants.fontStyleBold(
                                        pvd.restDetails!.reviews![index].rating!
                                            .toStringAsFixed(1),
                                        fontSize: 18,
                                        colorValue: Color(0xFF3D525C)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              constants.fontStyleRegular(
                                  pvd.restDetails!.reviews![index].created
                                      .toString(),
                                  fontSize: 21,
                                  colorValue: Color(0xff7A7A7A)),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: constants.textAutoNewLine(
                                  pvd.restDetails!.reviews![index].message
                                      .toString(),
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                          divider()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ]),
    ),
  );
}

Widget divider() {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    child: Divider(
      color: const Color(0x90FEBC18),
      thickness: 1,
    ),
  );
}

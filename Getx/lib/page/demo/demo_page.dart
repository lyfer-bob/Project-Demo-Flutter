import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/controllers/demo/demo_controller.dart';
import 'package:project/controllers/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:project/utils/text/text_app.dart';

class DemoPage extends GetView<DemoController> {
  final ctrLogin = Get.find<LoginController>();

// export PATH=/opt/homebrew/bin:$PATH

// #FLUTTER PATH
// export PATH="$PATH:/Users/macbob/development/flutter/bin"
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        initState: (_) {
          controller.init();
        },
        builder: (_) {
          return Scaffold(
              // bottomNavigationBar: CurvedNavigationBar(
              //   backgroundColor: Colors.blueAccent,
              //   items: <Widget>[
              //     Icon(Icons.add, size: 30),
              //     Icon(Icons.list, size: 30),
              //     Icon(Icons.compare_arrows, size: 30),
              //   ],
              //   onTap: (index) {
              //     //Handle button tap
              //   },
              // ),
              body: SingleChildScrollView(
                  child: Column(children: [
            // _header(context),
            // _searchAndSlideBar(context),
            // Padding(
            //   padding: const EdgeInsets.only(top: 250.0),
            //   child: TextApp(
            //     text: 'Map',
            //     fontSize: 50,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, right: 35, left: 35),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.mapLocation,
                                color: Colors.white,
                                size: 14,
                              ),
                              TextApp(
                                text: 'Stations',
                                fontColor: Colors.white,
                                fontSize: 10,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.user,
                                color: Colors.grey,
                                size: 14,
                              ),
                              TextApp(
                                text: 'Profile',
                                fontColor: Colors.grey,
                                fontSize: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(30.0),
                  //       topRight: Radius.circular(30.0)),
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     width: 140,
                  //     height: 70,
                  //     decoration: BoxDecoration(
                  //       color: Colors.black,
                  //     ),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         ClipOval(
                  //           child: Container(
                  //             width: 45,
                  //             height: 45,
                  //             color: Color.fromARGB(255, 35, 148, 148),
                  //             child: Icon(
                  //               Icons.qr_code_scanner,
                  //               color: Colors.white,
                  //               size: 30,
                  //             ),
                  //           ),
                  //         ),
                  //         TextApp(
                  //           text: 'Scan',
                  //           fontColor: Colors.white,
                  //           fontSize: 10,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Container(
                    color: Colors.transparent,
                    height: 75,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: -40 - (75.0 - 75),
                          left: Directionality.of(context) == TextDirection.rtl
                              ? null
                              : 2 * 100,
                          right: Directionality.of(context) == TextDirection.rtl
                              ? 2 * 100
                              : null,
                          width: 100 / 2,
                          child: Center(
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                -(1 - 1) * 80,
                              ),
                              child: Material(
                                color: Colors.white,
                                type: MaterialType.circle,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.cabin),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0 - (75.0 - 75),
                          child: CustomPaint(
                            // painter: NavCustomPainter(
                            //     _pos, _length, widget.color, Directionality.of(context)),
                            child: Container(
                              height: 75.0,
                            ),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0 - (75.0 - 75),
                            child: Text('')),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ])));
        });
  }

  Padding _searchAndSlideBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color.fromARGB(255, 65, 230, 230),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(39, 49, 5, 5),
                    offset: Offset(2, 3),
                    blurRadius: 2,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: TextField(
                  autocorrect: true,
                  autofocus: true,
                  cursorWidth: 1,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontFamily: 'Promt',
                      fontSize: 14,
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
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        fontFamily: 'Promt',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.125,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Color.fromARGB(255, 65, 230, 230),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(39, 49, 5, 5),
                  offset: Offset(2, 3),
                  blurRadius: 2,
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: FaIcon(
              FontAwesomeIcons.sliders,
              size: 17,
            ),
          )
        ],
      ),
    );
  }

  Container _header(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)),
        color: Color.fromARGB(255, 5, 101, 179),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: ClipOval(
                child: Container(
                    color: Colors.black,
                    width: 50,
                    height: 50,
                    child: Center(
                      child: TextApp(
                        text: 'Pic',
                        fontColor: Colors.white,
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                    text: 'Tesla Model 3',
                    fontColor: Colors.grey,
                    fontSize: 14,
                  ),
                  TextApp(
                    text: 'Pattrick checz',
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ],
              ),
            ),
            Container(
              width: 102,
              height: 52,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Color.fromARGB(74, 97, 95, 95),
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextApp(
                          text: 'Wallet',
                          fontSize: 11,
                          fontColor: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                          child: FaIcon(
                            FontAwesomeIcons.wallet,
                            size: 12,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    TextApp(
                      text: '780.00',
                      fontSize: 14.5,
                      fontColor: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      width: 4,
                      color: Color.fromARGB(68, 97, 95, 95),
                    ),
                    borderRadius: BorderRadius.circular(35),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Color.fromARGB(39, 49, 5, 5),
                    //       offset: Offset(2, 3),
                    //       blurRadius: 10,
                    //       spreadRadius: 5,
                    //     ),
                    //   ],
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.bell,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

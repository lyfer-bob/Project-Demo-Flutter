import 'package:flutter/material.dart';
import 'package:/screen/Fragment/RestaurantMain/RestaurantDetail/RestaurantDetailProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

Widget foodDetail() {
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: pvd.stsbottomsheet
                ? MediaQuery.of(context).size.height * 0.19
                : 165),
        child: listData(context),
      ),
    ),
  );
}

Widget listData(BuildContext context) {
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => Column(children: [
      Padding(
        padding: Constants.paddingAppLRT,
        child: Column(
          children: [
            cardList('ชื่อร้านค้า', pvd.restDetails!.restaurantName.toString(),
                context),
            cardList('เบอร์ติดต่อ', pvd.restDetails!.restaurantPhone.toString(),
                context),
            cardList(
                'ที่อยู่', pvd.restDetails!.contactAddress.toString(), context,
                lat: pvd.restDetails!.sourcelatitude,
                lng: pvd.restDetails!.sourcelongitude),
          ],
        ),
      ),
      Padding(
        padding: Constants.paddingAppLRTB,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 8, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Constants()
                        .fontStyleRegular('เวลาเปิดทำการ', fontSize: 23),
                  ),
                  Column(
                    children: [
                      rowData(
                        header: 'อาทิตย์',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.sundayStatus,
                            timeFirstOpen: pvd.restDetails!.sundayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.sundayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.sundaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.sundaySecondClosetime),
                      ),
                      divider(),
                      rowData(
                        header: 'จันทร์',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.mondayStatus,
                            timeFirstOpen: pvd.restDetails!.mondayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.mondayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.mondaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.mondaySecondClosetime),
                      ),
                      divider(),
                      rowData(
                        header: 'อังคาร',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.tuesdayStatus,
                            timeFirstOpen:
                                pvd.restDetails!.tuesdayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.tuesdayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.tuesdaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.tuesdaySecondClosetime),
                      ),
                      divider(),
                      rowData(
                        header: 'พุธ',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.wednesdayStatus,
                            timeFirstOpen:
                                pvd.restDetails!.wednesdayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.wednesdayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.wednesdaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.wednesdaySecondClosetime),
                      ),
                      divider(),
                      rowData(
                        header: 'พฤหัสบดี',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.thursdayStatus,
                            timeFirstOpen:
                                pvd.restDetails!.thursdayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.thursdayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.thursdaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.thursdaySecondClosetime),
                      ),
                      divider(),
                      rowData(
                        header: 'ศุกร์',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.fridayStatus,
                            timeFirstOpen: pvd.restDetails!.fridayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.fridayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.fridaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.fridaySecondClosetime),
                      ),
                      divider(),
                      rowData(
                        header: 'เสาร์',
                        value: timeStartandEnd(
                            timeStatus: pvd.restDetails!.saturdayStatus,
                            timeFirstOpen:
                                pvd.restDetails!.saturdayFirstOpentime,
                            timeFirstClose:
                                pvd.restDetails!.saturdayFirstClosetime,
                            timeSecondOpen:
                                pvd.restDetails!.saturdaySecondOpentime,
                            timeSecondClose:
                                pvd.restDetails!.saturdaySecondClosetime),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]),
  );
}

Widget cardList(String header, String detail, BuildContext context,
    {String? lat, lng}) {
  CameraPosition? initialCameraPosition = CameraPosition(
      //bearing: 0,
      target: lat != null
          ? LatLng(double.parse(lat), double.parse(lng))
          : LatLng(13.6413561, 100.499878),
      tilt: 59.440717697143555,
      zoom: 15);

  var constants = Constants();
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constants.fontStyleRegular(header, fontSize: 23),
            header == 'ที่อยู่'
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: constants.textAutoNewLine(detail, fontSize: 18),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        //color: Colors.red,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          initialCameraPosition: initialCameraPosition,
                        ),

                        // Center(
                        //   child: constants.fontStyleRegular('googlemap',
                        //       fontSize: 18),
                        // ),
                      )
                    ],
                  )
                : constants.fontStyleRegular(detail, fontSize: 18),
          ],
        ),
      ),
    ),
  );
}

Widget timeStartandEnd(
    {String? timeStatus,
    String? timeFirstOpen,
    String? timeFirstClose,
    String? timeSecondOpen,
    String? timeSecondClose}) {
  var constants = Constants();
  return timeStatus == 'Close'
      ? constants.fontStyleRegular('Close', fontSize: 17)
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            constants.fontStyleRegular('$timeFirstOpen - $timeFirstClose',
                fontSize: 17),
            Visibility(
              visible: !(timeSecondOpen == '' && timeSecondClose == ''),
              child: constants.fontStyleRegular(
                  '$timeSecondOpen - $timeSecondClose',
                  fontSize: 17),
            ),
          ],
        );
}

Widget rowData({String? header, Widget? value}) {
  return Consumer<RestaurantDetailProvider>(
    builder: (context, pvd, child) => Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Constants().fontStyleRegular(header!, fontSize: 17))),
          Expanded(
            flex: 7,
            child: Center(child: value!),
          ),
        ],
      ),
    ),
  );
}

Widget divider() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, right: 5),
    child: Divider(
      color: Color(0x30FEBC18),
      thickness: 1,
    ),
  );
}

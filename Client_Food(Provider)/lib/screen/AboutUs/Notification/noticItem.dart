import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:/model/FromJSON/noticListModel.dart';
import 'package:/screen/AboutUs/Notification/notic_detail.dart';
import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:/screen/Fragment/BasketPage/DetailDelivery/DetailDeliveryProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

@override
Widget noticItems(BuildContext context,
    {int index = 0, required List<Items> listdata, String? flagePage}) {
  Content content = listdata[index].content!;

  return Consumer2<DetailDeliveryProvider, GlobalURLProvider>(
    builder: (context, pvd, pvdglobal, child) => InkWell(
      onTap: () async {
        await pvdglobal.notifyReadUpdateToAPI(listdata[index].id, flagePage!);

        if (listdata[index].typeId == 1) {
          if (listdata[index].typeId != null) {
            pvd.getDataByOrderList(listdata[index].orderId!, page: 'noti');
            Navigator.pushNamed(context, '/detailDelivery');
          } else {
            Constants().progressAPI();
          }
        } else if (listdata[index].typeId == 2) {
          if (listdata[index].url!.isNotEmpty) {
            // ignore: deprecated_member_use
            launch(listdata[index].url.toString());
          } else
            Navigator.pushNamed(
              context,
              '/noticDetail',
              arguments: NoticDetailValues(listdata[index].subject.toString(),
                  listdata[index].contentAll.toString()),
            );
        }

        pvdglobal.globalUrlModel!.status == "OK"
            ? pvdglobal.getNotiData(flagePage)
            : print('GlobalURL status not OK!!');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 17,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  child: listdata[index].typeId == 1
                      ? listdata[index].statusRead == false
                          ? //orderUnread
                          SvgPicture.asset('assets/images/noti_image1.svg')
                          : //orderRead
                          SvgPicture.asset('assets/images/noti_image2.svg')
                      : listdata[index].typeId == 2
                          ? listdata[index].statusRead == false
                              ? //newsUnread
                              SvgPicture.asset('assets/images/noti_image3.svg')
                              : //newsRead
                              SvgPicture.asset('assets/images/noti_image4.svg')
                          : listdata[index].typeId == 3
                              ? listdata[index].statusRead == false
                                  ? //promotionUnread
                                  SvgPicture.asset(
                                      'assets/images/noti_image5.svg')
                                  : //promotionRead
                                  SvgPicture.asset(
                                      'assets/images/noti_image6.svg')
                              : SvgPicture.asset(
                                  'assets/images/noti_image1.svg'),
                ),
              ),
            ),
            Flexible(
              flex: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Constants().fontStyleBold(
                              listdata[index].typeId == 2
                                  ? listdata[index].title.toString()
                                  : content.header.toString(),
                              fontSize: 20),
                          Constants().fontStyleRegular(
                              listdata[index].date.toString(),
                              fontSize: 18),
                        ],
                      ),
                    ),
                    listdata[index].typeId == 2
                        ? Constants().fontStyleRegular(
                            listdata[index].subject.toString())
                        : Constants().fontStyleBold(
                            content.orderNumber.toString(),
                            fontSize: 20),
                    Visibility(
                      visible: flagePage != 'NewsAndProm' &&
                          listdata[index].typeId != 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Constants().fontStyleRegular(content.status ?? '',
                              fontSize: 18),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Constants()
                                .textAutoNewLine(content.reason ?? ''),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0x0D5FEBC18),
                // size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

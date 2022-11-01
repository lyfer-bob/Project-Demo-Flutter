import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';
import 'package:/utils/SizeConfig.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Constants().leadingBackIconAppBar(context),
        centerTitle: false,
        title: Constants().fontStyleBold('FAQ', fontSize: 21),
        flexibleSpace: Constants().flexibleSpaceInAppBar(),
      ),
      body: Container(
        child: Column(
          children: [
            logoEatHub(),
            Padding(
              padding: Constants.paddingAppLRTB,
              child: Constants().textAutoNewLine('คำถามที่พบบ่อย (FAQ)',
                  colorValue: Colors.black, fontSize: 16),
            ),
            Expanded(child: listItemFAQ()),
          ],
        ),
      ),
    );
  }

  Widget logoEatHub() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo.jpg',
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          ),
          Icon(
            Icons.menu_rounded,
            color: Colors.amber,
          )
        ],
      ),
    );
  }

  Widget listItemFAQ() {
    return Scaffold(
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(10)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/faq_ic.png',
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Constants().textAutoNewLine(
                            'ต้องการเปลี่ยนอีเมลในการรับสัญญาควรทำอย่างไร?',
                            colorValue: Colors.black,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Constants().textAutoNewLine(
                                  'ในกรณีที่ร้านค้ายังไม่ได้ส่งเอกสารสัญญาและยังไม่ได้รับการติดต่อกลับจากเจ้าหน้าที่ xxxxxxท่านจะต้องสมัครเข้ามาใหม่เท่านั้น แต่หากร้านค้าได้ดำเนินการส่งเอกสารสัญญาให้กับทางxxxxxx แล้ว กรุณารอการติดต่อกลับจากเจ้าหน้าที่ และแจ้งแก้ไขอีเมลล์ลกับทางเจ้าหน้าที่โดยตรงได้เลย',
                                  colorValue: Colors.black,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

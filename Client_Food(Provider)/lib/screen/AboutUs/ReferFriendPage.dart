import 'package:clipboard/clipboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:/screen/Profile/provider/ProfileCustomerProvider.dart';
import 'package:/utils/Constants.dart';
import 'package:provider/provider.dart';

enum Share { facebook, twitter, whatsapp, whatsapp_business, share_system }

class ReferFriendPage extends StatefulWidget {
  const ReferFriendPage({Key? key}) : super(key: key);

  @override
  _ReferFriendPageState createState() => _ReferFriendPageState();
}

class _ReferFriendPageState extends State<ReferFriendPage> {
  String msg = '';

  void initState() {
    super.initState();
    Provider.of<ProfileCustomerProvider>(context, listen: false)
        .initData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Constants().leadingBackIconAppBar(context),
          centerTitle: false,
          title: Constants().fontStyleBold('แนะนำเพื่อน', fontSize: 21),
          flexibleSpace: Constants().flexibleSpaceInAppBar(),
        ),
        body: Container(
          child: Column(
            children: [
              header(),
              textDescription(),
              yourReferralCode(),
              image(),
              shareLink(),
              // iconSocial(),
            ],
          ),
        ));
  }

  Widget image() {
    return Container(
      child: Image.asset(
        'assets/images/friend_ic.png',
        height: 200,
        width: 300,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
              child: Constants().fontStyleBold('แชร์ Referral', fontSize: 18)),
        ),
        Divider(
          height: 1,
          indent: 15,
          endIndent: 15,
          thickness: 1,
          color: Color(0xFFFEBC18),
        )
      ],
    );
  }

  Widget textDescription() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Constants().fontStyleBold('เชิญเพื่อนร่วมใช้งาน xxxxxx รับ 25 ฿',
                  fontSize: 16, colorValue: Color(0xFF7A7A7A)),
              Constants().fontStyleBold('เมื่อเพื่อนคุณลงทะเบียนเรียบร้อย',
                  fontSize: 16, colorValue: Color(0xFF7A7A7A)),
              Constants().fontStyleBold('เพื่อนคุณจะได้รับ 45 ฿',
                  fontSize: 16, colorValue: Color(0xFF7A7A7A))
            ],
          ),
        ),
      ),
    );
  }

  Widget yourReferralCode() {
    return Consumer<ProfileCustomerProvider>(
      builder: (context, pvd, child) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          color: Colors.amber,
          borderType: BorderType.RRect,
          radius: Radius.circular(2),
          padding: EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Center(
                  child: Column(
                children: [
                  Constants().fontStyleBold('รหัสอ้างอิงของคุณ',
                      fontSize: 14, colorValue: Color(0xFF7A7A7A)),
                  Constants().fontStyleBold(
                      '${pvd.model?.result?.customerDetails?.referralCode}',
                      fontSize: 20),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  Widget shareLink() {
    return Consumer<ProfileCustomerProvider>(
      builder: (context, pvd, child) => Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Constants().fontStyleBold('แชร์ลิงค์เว็บแนะนำเพื่อน',
                      fontSize: 16, colorValue: Color(0xFF7A7A7A)),
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // onButtonTap(Share.share_system);
                      }),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.89,
              color: Color(0xFFF3F3F3),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Constants().fontStyleRegular(
                      '/${pvd.model?.result?.customerDetails?.referralCode}',
                      fontSize: 14,
                      colorValue: Color(0xFF7A7A7A)),
                  InkWell(
                    onTap: () {
                      FlutterClipboard.copy(
                              '${pvd.model?.result?.customerDetails?.referralCode}')
                          .then((value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('คัดลอกสำเร็จ!!'),
                                    action: SnackBarAction(
                                      label: 'เลิกทำ',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  ))
                              // print('copied')
                              );
                    },
                    child: Icon(
                      Icons.copy,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onClipboardText(String text) {
    print("clipboard changed: $text");
  }

  Widget iconSocial() {
    return Consumer<ProfileCustomerProvider>(
      builder: (context, pvd, child) => Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                // onTap: () => onButtonTap(Share.share_system),
                child: Image.asset(
                  'assets/images/line_ic.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),
              InkWell(
                // onTap: () => onButtonTap(Share.share_system),
                child: Image.asset(
                  'assets/images/fb_ic.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),
              InkWell(
                // onTap: () => onButtonTap(Share.share_system),
                child: Image.asset(
                  'assets/images/twitter_ic.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),
              InkWell(
                // onTap: () => onButtonTap(Share.share_system),
                child: Image.asset(
                  'assets/images/sms_ic.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.fill,
                ),
              ),
              // Image.asset(
              //   'assets/images/mail_ic.png',
              //   height: 50,
              //   width: 50,
              //   fit: BoxFit.fill,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

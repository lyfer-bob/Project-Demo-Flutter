import 'package:ProjectName/screen/AboutUs/provider/globalURL_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Constants.dart';

Future<Null> phoneCallDialog(BuildContext context, String string,
    {onPressed, String? text}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
          leading: Icon(
            Icons.phone_forwarded_sharp,
            color: Colors.green,
          ),
          title: Text(
            string,
            style: TextStyle(
                fontFamily: 'THSarabun',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: onPressed ??
                    () {
                      Navigator.pop(context);
                    },
                child: Constants().fontStyleBold(text ?? 'ยกเลิก',
                    fontSize: 20, colorValue: Colors.red)),
            Consumer<GlobalURLProvider>(
              builder: (context, pvd, child) => TextButton(
                  onPressed: onPressed ??
                      () {
                        _phoneCall('tel:${pvd.callCenterNumber}');
                      },
                  child: Constants().fontStyleBold(text ?? 'โทร',
                      fontSize: 20, colorValue: Colors.green)),
            )
          ],
        ),
      ],
    ),
  );
}

Future<void> _phoneCall(String url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

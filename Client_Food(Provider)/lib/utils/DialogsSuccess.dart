import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'Constants.dart';

Future<Null> normalDialog(BuildContext context, String string,
    {onPressed,
    onPressedSec,
    String? text,
    String? textSec,
    bool? dialogYesNo}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
          leading: Constants().showLogo(),
          title: Constants().textAutoNewLine(string, fontSize: 20)),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: dialogYesNo ?? false,
              child: TextButton(
                  onPressed: onPressedSec ?? () => Navigator.pop(context),
                  child: Constants()
                      .fontStyleRegular(textSec ?? 'ยกเลิก', fontSize: 20)),
            ),
            TextButton(
                onPressed: onPressed ?? () => Navigator.pop(context),
                child:
                    Constants().fontStyleRegular(text ?? 'ตกลง', fontSize: 20)),
          ],
        ),
      ],
    ),
  );
}

Future<Null> locationPremission(BuildContext context, String string,
    {onPressed,
    onPressedSec,
    String? text,
    String? textSec,
    bool? dialogYesNo}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
          leading: Constants().showLogo(),
          title: Constants().textAutoNewLine(string, fontSize: 20)),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: dialogYesNo ?? false,
              child: TextButton(
                  onPressed: onPressedSec ??
                      () => Navigator.popUntil(
                          context, ModalRoute.withName('/fragment')),
                  child: Constants()
                      .fontStyleRegular(textSec ?? 'Cancel', fontSize: 20)),
            ),
            TextButton(
                onPressed: onPressed ??
                    () async {
                      LocationPermission _status =
                          await Geolocator.checkPermission();

                      Constants().printColorBlue('_statusIn Button:: $_status');

                      if (_status == LocationPermission.denied) {
                        Geolocator.openAppSettings();
                        Navigator.popUntil(
                            context, ModalRoute.withName('/fragment'));
                      } else {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/fragment'));
                      }
                    },
                child:
                    Constants().fontStyleRegular(text ?? 'Ok', fontSize: 20)),
          ],
        ),
      ],
    ),
  );
}

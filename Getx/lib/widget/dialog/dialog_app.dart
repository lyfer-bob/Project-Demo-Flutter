import 'package:flutter/material.dart';
import 'package:project/widget/text/text_app.dart';
import 'package:project/widget/text/text_auto_newline.dart';

Future<dynamic> normalDialog(BuildContext context, String string,
    {onPressed,
    onPressedSec,
    String? text,
    String? textSec,
    bool? dialogYesNo}) async {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: SimpleDialog(
          title: ListTile(
              leading: TextApp(text: ''),
              title: (TextAutonNewline(
                text: string,
              ))),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: dialogYesNo ?? false,
                  child: TextButton(
                      onPressed: onPressedSec ?? () => Navigator.pop(context),
                      child: TextApp(text: textSec ?? 'ยกเลิก', fontSize: 20)),
                ),
                TextButton(
                    onPressed: onPressed ?? () => Navigator.pop(context),
                    child: TextApp(text: text ?? 'ตกลง', fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

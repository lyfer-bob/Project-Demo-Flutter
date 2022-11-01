import 'package:flutter/material.dart';
import 'Constants.dart';

class AlertYesNoDialog extends StatelessWidget {
  final onTabyes;
  final onTabno;
  final String? content;
  final Text? title;
  final String? textConfirm;
  final String? textCancle;

  AlertYesNoDialog({
    @required this.content,
    @required this.title,
    this.textConfirm,
    this.textCancle,
    @required this.onTabyes,
    @required this.onTabno,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Constants().fontStyleRegular(
        content ?? '',
        fontSize: 14,
        colorValue: Colors.black,
      ),
      backgroundColor: Colors.white,
      elevation: 5,
      actionsPadding: EdgeInsets.all(8),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
      actions: <Widget>[
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: buttonYesNo(
                  context, textConfirm ?? 'ตกลง', onTabyes, Color(0xFF5ABF6F)),
            ),
            buttonYesNo(context, textCancle ?? 'ยกเลิก', onTabno, Colors.red),
          ],
        ),
      ],
    );
  }

  Container buttonYesNo(
      BuildContext context, String text, onPressed, Color bgcolor) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.transparent)),
      width: 120,
      height: 60,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: bgcolor,
          visualDensity: VisualDensity(horizontal: 1),
        ),
        autofocus: true,
        clipBehavior: Clip.none,
        onPressed: onPressed,
        child: Constants()
            .fontStyleRegular(text, fontSize: 18.00, colorValue: Colors.white),
      ),
    );
  }
}

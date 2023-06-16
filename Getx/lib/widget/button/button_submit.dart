import 'package:flutter/material.dart';
import 'package:project/widget/text/text_app.dart';

class ButtonSubmit extends StatelessWidget {
  final double? width;
  final double? height;
  final onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final String? text;
  final double? fontSize;
  final BorderRadius? borderRadius;

  ButtonSubmit({
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.fontColor,
    this.fontSize,
    this.borderRadius,
    @required this.text,
    this.onPressed,
  });

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          color: backgroundColor ?? Color(0xFF5ABF6F),
        ),
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(15),
              backgroundColor: backgroundColor ?? Color(0xFF5ABF6F),
              visualDensity: VisualDensity(horizontal: 1),
            ),
            autofocus: true,
            clipBehavior: Clip.none,
            onPressed: onPressed,
            child: TextApp(
                text: text ?? 'ยืนยัน',
                overflow: TextOverflow.visible,
                fontSize: fontSize ?? 18.00,
                fontColor: fontColor ?? Colors.black),
          ),
        ));
  }
}

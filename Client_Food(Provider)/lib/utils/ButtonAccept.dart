import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';

class ButtonAccept extends StatefulWidget {
  final double? width;
  final double? height;
  final onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final String? text;
  final double? fontSize;
  final bool? fontStyleRegular;

  ButtonAccept({
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.fontColor,
    this.fontSize,
    this.fontStyleRegular,
    @required this.text,
    @required this.onPressed,
  });

  @override
  _ButtonAccept createState() => _ButtonAccept();
}

class _ButtonAccept extends State<ButtonAccept> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: widget.borderColor ?? Colors.transparent)),
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: widget.backgroundColor ?? Color(0xFF5ABF6F),
          visualDensity: VisualDensity(horizontal: 1),
        ),
        autofocus: true,
        clipBehavior: Clip.none,
        onPressed: widget.onPressed,
        child: widget.fontStyleRegular == false
            ? Constants().fontStyleBold(widget.text ?? 'ยืนยัน',
                fontSize: widget.fontSize ?? 21.00,
                colorValue: widget.fontColor ?? Colors.black)
            : Constants().fontStyleRegular(widget.text ?? 'ยืนยัน',
                fontSize: widget.fontSize ?? 21.00,
                colorValue: widget.fontColor ?? Colors.black),
      ),
    );
  }
}

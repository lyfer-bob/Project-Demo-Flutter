import 'package:flutter/material.dart';
import 'package:/utils/Constants.dart';

class ButtonAcceptIcon extends StatefulWidget {
  final double? width;
  final double? height;
  final onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final String? text;
  final double? fontSize;
  final Icon? icon;
  final IconButton? buttonicon;
  final bool? fontStyleRegular;

  ButtonAcceptIcon({
    this.width,
    this.height,
    this.backgroundColor,
    this.fontColor,
    this.borderColor,
    this.buttonicon,
    this.icon,
    this.fontSize,
    this.fontStyleRegular,
    @required this.onPressed,
    @required this.text,
  });

  @override
  _ButtonAcceptIcon createState() => _ButtonAcceptIcon();
}

class _ButtonAcceptIcon extends State<ButtonAcceptIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: widget.borderColor ?? Colors.transparent)),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: widget.backgroundColor ?? Color(0xFF5ABF6F),
          visualDensity: VisualDensity(horizontal: 1),
        ),
        label: widget.fontStyleRegular == false
            ? Constants().fontStyleBold(widget.text ?? 'ยืนยัน',
                fontSize: widget.fontSize ?? 21.00,
                colorValue: widget.fontColor ?? Colors.black)
            : Constants().fontStyleRegular(widget.text ?? 'ยืนยัน',
                fontSize: widget.fontSize ?? 21.00,
                colorValue: widget.fontColor ?? Colors.black),
        autofocus: true,
        clipBehavior: Clip.none,
        onPressed: widget.onPressed,
        icon: widget.icon ?? widget.buttonicon!,
      ),
    );
  }
}

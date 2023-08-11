import 'package:flutter/material.dart';

class ButtonAccept extends StatefulWidget {
  final double? width;
  final double? height;
  final dynamic onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final String? text;
  final double? fontSize;
  final bool? fontStyleRegular;

  const ButtonAccept({
    super.key,
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
  State<ButtonAccept> createState() => _ButtonAccept();
}

class _ButtonAccept extends State<ButtonAccept> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border:
                Border.all(color: widget.borderColor ?? Colors.transparent)),
        width: widget.width ?? double.infinity,
        height: widget.height,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: widget.backgroundColor ?? const Color(0xFF5ABF6F),
            visualDensity: const VisualDensity(horizontal: 1),
          ),
          autofocus: true,
          clipBehavior: Clip.none,
          onPressed: widget.onPressed,
          child: widget.fontStyleRegular == false
              ? Text(widget.text ?? 'Accept',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.fontSize ?? 21.00,
                      color: widget.fontColor ?? Colors.black))
              : Text(
                  widget.text ?? 'Accept',
                  style: TextStyle(
                      fontSize: widget.fontSize ?? 21.00,
                      color: widget.fontColor ?? Colors.black),
                ),
        ));
  }
}

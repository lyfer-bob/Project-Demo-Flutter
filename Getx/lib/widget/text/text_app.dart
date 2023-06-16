import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  final TextOverflow? overflow;
  final Color? fontColor;
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;

  const TextApp({
    this.overflow,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow ?? TextOverflow.fade,
      softWrap: false,
      style: TextStyle(
          fontFamily: 'Prompt',
          fontSize: fontSize ?? 20,
          color: fontColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}

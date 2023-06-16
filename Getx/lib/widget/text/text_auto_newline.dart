import 'package:flutter/material.dart';

class TextAutonNewline extends StatelessWidget {
  final TextOverflow? overflow;
  final Color? fontColor;
  final String? text;
  final double? fontSize;
  final bool? alignCenter;

  const TextAutonNewline({
    super.key,
    this.overflow,
    this.fontColor,
    this.fontSize,
    this.alignCenter,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignCenter == true
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: alignCenter == true
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                text!,
                style: TextStyle(
                    height: 1,
                    fontFamily: 'Prompts',
                    fontSize: fontSize ?? 17.0,
                    color: fontColor ?? Colors.black,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class TextAutonNewline extends StatelessWidget {
  final TextOverflow? overflow;
  final String? text;
  final TextStyle? style;
  final MainAxisAlignment? mainAxisAlignmentRow;
  final MainAxisAlignment? mainAxisAlignmentColumn;
  const TextAutonNewline({
    super.key,
    required this.text,
    this.overflow,
    this.style,
    this.mainAxisAlignmentRow,
    this.mainAxisAlignmentColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignmentRow ?? MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment:
                mainAxisAlignmentColumn ?? MainAxisAlignment.start,
            children: [
              Text(
                text!,
                style: style ??
                    const TextStyle(
                        height: 1,
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

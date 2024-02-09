import 'package:flutter/material.dart';

class DefaultTableCellWidget extends StatelessWidget {
  final double? height;
  final String text;
  final TextStyle? tStyle;
  const DefaultTableCellWidget(
      {super.key,
      required this.height,
      required this.text,
      required this.tStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: tStyle,
      ),
    );
  }
}

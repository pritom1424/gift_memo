import 'package:flutter/material.dart';
import '../../core/utils/custom_widget.dart';

class TopBarFiterScreen extends StatelessWidget {
  const TopBarFiterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomWidgetsUtils().topfilterButton('All', () {}),
        CustomWidgetsUtils().topfilterButton('Gift', () {}),
        CustomWidgetsUtils().topfilterButton('Money', () {}),
        CustomWidgetsUtils().topfilterButton('Both', () {}),
      ],
    );
  }
}

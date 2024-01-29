import 'package:flutter/material.dart';
import 'package:gift_memo/presentation/screens/giftmemo_listscn.dart';
import 'package:gift_memo/presentation/screens/topBar_filterscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TopBarFiterScreen(),
          Expanded(child: GiftMemoListScreen()),
        ],
      ),
    );
  }
}

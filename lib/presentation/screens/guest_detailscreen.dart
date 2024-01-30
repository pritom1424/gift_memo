import 'package:flutter/material.dart';
import 'package:gift_memo/core/utils/utils.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:gift_memo/presentation/screens/input_screen.dart';

class GuestDetailsScreen extends StatelessWidget {
  final GiftMemoModel gModel;
  const GuestDetailsScreen(this.gModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest Details"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(child: Text(gModel.name)),
            FittedBox(child: Text(gModel.gender.name)),
            FittedBox(
              child: Text(Utils().giftTypeToDetailsText(gModel)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Values.currentMemoModel = gModel;
          Navigator.of(context).pushNamedAndRemoveUntil(
              Values.inputScreenRouteName, (route) => false);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:gift_memo/presentation/widgets/details_profile_widget.dart';
import 'package:gift_memo/presentation/widgets/details_summaryTable_widget.dart';

class GuestDetailsScreen extends StatelessWidget {
  final GiftMemoModel gModel;
  const GuestDetailsScreen(this.gModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guest Details"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DetailsProfileWidget(gModel),
            DetailsSummaryTableWidget(gModel),
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

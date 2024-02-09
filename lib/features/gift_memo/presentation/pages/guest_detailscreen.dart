import 'package:flutter/material.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/details_profile_widget.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/details_summaryTable_widget.dart';

class GuestDetailsScreen extends StatelessWidget {
  final GiftMemo giftMemo;
  const GuestDetailsScreen({required this.giftMemo, super.key});

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
            DetailsProfileWidget(giftMemo),
            DetailsSummaryTableWidget(giftMemo),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          GenericVariables.currentGiftMemo = giftMemo;
          Navigator.of(context).pushNamedAndRemoveUntil(
              GenericVariables.inputScreenRouteName, (route) => false);
        },
      ),
    );
  }
}

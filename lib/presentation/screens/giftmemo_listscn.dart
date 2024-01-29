import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/data/models/gift.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:gift_memo/presentation/widgets/single_gift_memo_card.dart';

class GiftMemoListScreen extends StatelessWidget {
  const GiftMemoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gModel = GiftMemoModel(
        id: "0",
        name: "fatema",
        gift: WeddingHybridGift(
            gName: "Toaster", mName: "Tk", gAmount: 1, mAmount: 5000),
        gender: GuestGender.female,
        date: DateTime.now());
    return ListView.builder(
        itemBuilder: (ctx, i) => Dismissible(
            key: ValueKey(gModel),
            confirmDismiss: (dir) =>
                CustomWidgetsUtils().deleteAlertDialoguePop(context),
            child: SingleGiftMemoCard(gModel)));
  }
}

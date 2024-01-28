import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import '../../core/giftmemo_enums/gifttype.dart';
import '../../data/models/gift_memo_model.dart';
import '../../core/utils/utils.dart';

class SingleGiftMemoCard extends StatelessWidget {
  final GiftMemoModel _giftMemoModel;
  const SingleGiftMemoCard(this._giftMemoModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _giftMemoModel.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  (_giftMemoModel.gift.gType == GiftType.both)
                      ? "${_giftMemoModel.gift.giftName} + ${_giftMemoModel.gift.moneyAmount}+${_giftMemoModel.gift.giftMoneyName}"
                      : (_giftMemoModel.gift.gType == GiftType.gift)
                          ? "${_giftMemoModel.gift.giftName}"
                          : "${_giftMemoModel.gift.moneyAmount}+${_giftMemoModel.gift.giftMoneyName}",
                  style: const TextStyle(
                      fontFamily: 'QuickSand-Medium',
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_giftMemoModel.gender.name),
                    Text(
                      Utils().dateTimeToText(_giftMemoModel.date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

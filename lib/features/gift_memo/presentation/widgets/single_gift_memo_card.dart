import 'package:flutter/material.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/methods/single_giftcard_text.dart';
import 'package:gift_memo/features/gift_memo/presentation/pages/guest_detailscreen.dart';

class SingleGiftMemoCard extends StatelessWidget {
  final GiftMemo _giftMemo;
  const SingleGiftMemoCard(this._giftMemo, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GuestDetailsScreen(
                  giftMemo: _giftMemo,
                )));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _giftMemo.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    SingleGiftCardText().giftTypeToCardText(_giftMemo),
                    style: const TextStyle(
                        fontFamily: 'QuickSand-Medium',
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    _giftMemo.gender.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

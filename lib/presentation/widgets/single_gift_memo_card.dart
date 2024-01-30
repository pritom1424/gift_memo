import 'package:flutter/material.dart';
import 'package:gift_memo/presentation/screens/guest_detailscreen.dart';
import '../../data/models/gift_memo_model.dart';
import '../../core/utils/utils.dart';

class SingleGiftMemoCard extends StatelessWidget {
  final GiftMemoModel _giftMemoModel;
  const SingleGiftMemoCard(this._giftMemoModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GuestDetailsScreen(_giftMemoModel)));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _giftMemoModel.name,
                // style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    Utils().giftTypeToCardText(_giftMemoModel),
                    style: const TextStyle(
                        // fontFamily: 'QuickSand-Medium',
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ),
                  const Spacer(),
                  Text(_giftMemoModel.gender.name),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

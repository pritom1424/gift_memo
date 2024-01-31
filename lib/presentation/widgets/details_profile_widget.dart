import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';

class DetailsProfileWidget extends StatelessWidget {
  final GiftMemoModel gModel;
  const DetailsProfileWidget(this.gModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage((gModel.gender == GuestGender.male)
                  ? Values.maleAvatarPath
                  : Values.femaleAvatarPath),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FittedBox(
                      child: Text(
                    gModel.name,
                    style: Theme.of(context).textTheme.labelLarge,
                  )),
                  FittedBox(child: Text(gModel.gender.name)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

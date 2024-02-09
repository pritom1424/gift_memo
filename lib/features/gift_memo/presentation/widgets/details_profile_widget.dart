import 'package:flutter/material.dart';
import 'package:gift_memo/core/generics/variables.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';

class DetailsProfileWidget extends StatelessWidget {
  final GiftMemo gModel;
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
                  ? GenericVariables.maleAvatarPath
                  : GenericVariables.femaleAvatarPath),
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

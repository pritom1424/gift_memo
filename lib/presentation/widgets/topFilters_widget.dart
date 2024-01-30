import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/memolist_type.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:provider/provider.dart';

class TopBarFiltersWidget extends StatelessWidget {
  const TopBarFiltersWidget({super.key});
  Row topBarFilters(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomWidgetsUtils().topfilterButton(
            'All',
            () => Provider.of<GiftMemoManager>(ctx, listen: false)
                .setCurrentMemoListType(MemoListType.all)),
        CustomWidgetsUtils().topfilterButton(
            'Gift',
            () => Provider.of<GiftMemoManager>(ctx, listen: false)
                .setCurrentMemoListType(MemoListType.gift)),
        CustomWidgetsUtils().topfilterButton(
            'Money',
            () => Provider.of<GiftMemoManager>(ctx, listen: false)
                .setCurrentMemoListType(MemoListType.money)),
        CustomWidgetsUtils().topfilterButton(
            'Both',
            () => Provider.of<GiftMemoManager>(ctx, listen: false)
                .setCurrentMemoListType(MemoListType.both)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return topBarFilters(context);
  }
}

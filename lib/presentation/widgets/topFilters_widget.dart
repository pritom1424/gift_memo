import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/memolist_type.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/utils.dart';
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
    return Consumer<GiftMemoManager>(
        child: topBarFilters(context),
        builder: (ctx, gmanager, ch) {
          return (gmanager.getMemo.isEmpty)
              ? ch!
              : Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      GiftSummaryTable(gmanager),
                      topBarFilters(context)
                    ],
                  ),
                );
        });
  }

  Container GiftSummaryTable(GiftMemoManager gM) {
    final totalGiftrecords = gM.getfilterdMemo(MemoListType.gift);
    final totalMoneyrecords = gM.getfilterdMemo(MemoListType.money);
    final totalBothrecords = gM.getfilterdMemo(MemoListType.both);

    String getTotalMoney() {
      double totalMoney = 0;
      for (int i = 0; i < totalMoneyrecords.length; i++) {
        totalMoney += totalMoneyrecords[i].gift.moneyAmount;
      }
      for (int i = 0; i < totalBothrecords.length; i++) {
        totalMoney += totalBothrecords[i].gift.moneyAmount;
      }

      return Utils().totalAmountFormatter(totalMoney);
    }

    return Container(
      color: Colors.grey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2)
        },
        children: [
          const TableRow(
              children: [Text("GiftType"), Text("Numbers"), Text("Total")]),
          TableRow(children: [
            const Text("Gift"),
            Text(totalGiftrecords.length.toString()),
            const Text("Money")
          ]),
          TableRow(
            children: [
              const Text("Money"),
              Text(totalMoneyrecords.length.toString()),
              Text("${getTotalMoney()} (tk)")
            ],
          ),
          TableRow(
            children: [
              const Text("Both"),
              Text(totalBothrecords.length.toString()),
              const Text("(Both+Money)")
            ],
          )
        ],
      ),
    );
  }
}

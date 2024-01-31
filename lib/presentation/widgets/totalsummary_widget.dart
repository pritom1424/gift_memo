import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/memolist_type.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/core/utils/utils.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';

class TotalSummaryWidget extends StatelessWidget {
  final double cellHeight;
  final GiftMemoManager gM;
  const TotalSummaryWidget(this.cellHeight, this.gM, {super.key});

  @override
  Widget build(BuildContext context) {
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ])),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(width: 0.5),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2)
        },
        children: [
          TableRow(children: [
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "GiftType", Theme.of(context).textTheme.bodyLarge),
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "Records", Theme.of(context).textTheme.bodyLarge),
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "Money +", Theme.of(context).textTheme.bodyLarge)
          ]),
          TableRow(children: [
            CustomWidgetsUtils()
                .defaultTableCellWidget(cellHeight, "Gift", null),
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, totalGiftrecords.length.toString(), null),
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "Both", Theme.of(context).textTheme.bodyLarge)
          ]),
          TableRow(
            children: [
              CustomWidgetsUtils()
                  .defaultTableCellWidget(cellHeight, "Money", null),
              CustomWidgetsUtils().defaultTableCellWidget(
                  cellHeight, totalMoneyrecords.length.toString(), null),
              CustomWidgetsUtils().defaultTableCellWidget(
                  cellHeight, "${getTotalMoney()} (tk)", null)
            ],
          ),
          TableRow(
            children: [
              CustomWidgetsUtils()
                  .defaultTableCellWidget(cellHeight, "Both", null),
              CustomWidgetsUtils().defaultTableCellWidget(
                  cellHeight, totalBothrecords.length.toString(), null),
              CustomWidgetsUtils().defaultTableCellWidget(cellHeight,
                  "(Total cash)", Theme.of(context).textTheme.bodyLarge)
            ],
          )
        ],
      ),
    );
  }
}

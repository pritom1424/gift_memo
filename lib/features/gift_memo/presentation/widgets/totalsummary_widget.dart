import 'package:flutter/material.dart';
import 'package:gift_memo/core/converters/converters.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/default_tablecellwidget.dart';

class TotalSummaryWidget extends StatelessWidget {
  final double cellHeight;
  final List<GiftMemo> memos;
  const TotalSummaryWidget(this.cellHeight, this.memos, {super.key});

  @override
  Widget build(BuildContext context) {
    final totalGiftrecords = GiftsFilterTypeToGiftListConverter(
            giftMemos: memos, mType: GiftMemosFilters.gift)
        .getfilterdMemo;
    final totalMoneyrecords = GiftsFilterTypeToGiftListConverter(
            giftMemos: memos, mType: GiftMemosFilters.money)
        .getfilterdMemo;
    final totalBothrecords = GiftsFilterTypeToGiftListConverter(
            giftMemos: memos, mType: GiftMemosFilters.both)
        .getfilterdMemo;

    String getTotalMoney() {
      double totalMoney = 0;
      for (int i = 0; i < totalMoneyrecords.length; i++) {
        totalMoney += totalMoneyrecords[i].gift.moneyAmount;
      }
      for (int i = 0; i < totalBothrecords.length; i++) {
        totalMoney += totalBothrecords[i].gift.moneyAmount;
      }

      return MoneytoFormattedMoneyConverter(amount: totalMoney)
          .totalAmountFormatter;
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
            DefaultTableCellWidget(
                height: cellHeight,
                text: "GiftType",
                tStyle: Theme.of(context).textTheme.bodyLarge),
            DefaultTableCellWidget(
                height: cellHeight,
                text: "Records",
                tStyle: Theme.of(context).textTheme.bodyLarge),
            DefaultTableCellWidget(
                height: cellHeight,
                text: "Money +",
                tStyle: Theme.of(context).textTheme.bodyLarge),
          ]),
          TableRow(children: [
            DefaultTableCellWidget(
              height: cellHeight,
              text: "Gift",
              tStyle: null,
            ),
            DefaultTableCellWidget(
                height: cellHeight,
                text: totalGiftrecords.length.toString(),
                tStyle: null),
            DefaultTableCellWidget(
                height: cellHeight,
                text: "Both",
                tStyle: Theme.of(context).textTheme.bodyLarge),
          ]),
          TableRow(
            children: [
              DefaultTableCellWidget(
                height: cellHeight,
                text: "Money",
                tStyle: null,
              ),
              DefaultTableCellWidget(
                  height: cellHeight,
                  text: totalMoneyrecords.length.toString(),
                  tStyle: null),
              DefaultTableCellWidget(
                  height: cellHeight,
                  text: "${getTotalMoney()} (tk)",
                  tStyle: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          TableRow(
            children: [
              DefaultTableCellWidget(
                height: cellHeight,
                text: "Both",
                tStyle: null,
              ),
              DefaultTableCellWidget(
                  height: cellHeight,
                  text: totalBothrecords.length.toString(),
                  tStyle: null),
              DefaultTableCellWidget(
                  height: cellHeight,
                  text: "(Total cash)",
                  tStyle: Theme.of(context).textTheme.bodyLarge),
            ],
          )
        ],
      ),
    );
  }
}

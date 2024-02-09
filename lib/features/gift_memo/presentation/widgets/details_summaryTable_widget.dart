import 'package:flutter/material.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';
import 'package:gift_memo/features/gift_memo/presentation/widgets/default_tablecellwidget.dart';

class DetailsSummaryTableWidget extends StatelessWidget {
  final GiftMemo gModel;
  const DetailsSummaryTableWidget(this.gModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final scSize = MediaQuery.of(context).size;
    final cellHeight = scSize.height * 0.05;
    return Flexible(
      flex: 5,
      child: Table(
        border: TableBorder.all(width: 1),
        children: [
          TableRow(children: [
            DefaultTableCellWidget(
                height: cellHeight,
                text: "GiftType",
                tStyle: Theme.of(context).textTheme.bodyLarge),
            DefaultTableCellWidget(
                height: cellHeight,
                text: "Name",
                tStyle: Theme.of(context).textTheme.bodyLarge),
            DefaultTableCellWidget(
                height: cellHeight,
                text: "Amount",
                tStyle: Theme.of(context).textTheme.bodyLarge),
          ]),
          if (gModel.gift.gType == GiftType.gift ||
              gModel.gift.gType == GiftType.both)
            TableRow(children: [
              DefaultTableCellWidget(
                  height: cellHeight, text: "Gift", tStyle: null),
              DefaultTableCellWidget(
                  height: cellHeight, text: gModel.gift.giftName, tStyle: null),
              DefaultTableCellWidget(
                  height: cellHeight,
                  text: "(x${gModel.gift.giftAmount})",
                  tStyle: null),
            ]),
          if (gModel.gift.gType == GiftType.money ||
              gModel.gift.gType == GiftType.both)
            TableRow(children: [
              DefaultTableCellWidget(
                  height: cellHeight, text: "Money", tStyle: null),
              DefaultTableCellWidget(
                  height: cellHeight, text: "Cash Envelope", tStyle: null),
              DefaultTableCellWidget(
                  height: cellHeight,
                  text: "${gModel.gift.moneyAmount}(Tk)",
                  tStyle: null),
            ]),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/gift_type.dart';
import 'package:gift_memo/core/utils/custom_widget.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';

class DetailsSummaryTableWidget extends StatelessWidget {
  final GiftMemoModel gModel;
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
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "GiftType", Theme.of(context).textTheme.bodyLarge),
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "Name", Theme.of(context).textTheme.bodyLarge),
            CustomWidgetsUtils().defaultTableCellWidget(
                cellHeight, "Amount", Theme.of(context).textTheme.bodyLarge),
          ]),
          if (gModel.gift.gType == GiftType.gift ||
              gModel.gift.gType == GiftType.both)
            TableRow(children: [
              CustomWidgetsUtils()
                  .defaultTableCellWidget(cellHeight, "Gift", null),
              CustomWidgetsUtils().defaultTableCellWidget(
                  cellHeight, gModel.gift.giftName, null),
              CustomWidgetsUtils().defaultTableCellWidget(
                  cellHeight, "(x${gModel.gift.giftAmount})", null),
            ]),
          if (gModel.gift.gType == GiftType.money ||
              gModel.gift.gType == GiftType.both)
            TableRow(children: [
              CustomWidgetsUtils()
                  .defaultTableCellWidget(cellHeight, "Money", null),
              CustomWidgetsUtils()
                  .defaultTableCellWidget(cellHeight, "Cash Envelope", null),
              CustomWidgetsUtils().defaultTableCellWidget(
                  cellHeight, "${gModel.gift.moneyAmount}(Tk)", null),
            ]),
        ],
      ),
    );
  }
}

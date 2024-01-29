import 'package:gift_memo/core/giftmemo_enums/gift_type.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:intl/intl.dart';

class Utils {
  String dateTimeToText(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }

  String giftTypeToCardText(GiftMemoModel giftMemoModel) {
    switch (giftMemoModel.gift.gType) {
      case GiftType.gift:
        return giftMemoModel.gift.giftName;
      case GiftType.both:
        return "${giftMemoModel.gift.giftName} + ${giftMemoModel.gift.moneyAmount}(${giftMemoModel.gift.giftMoneyName})";

      default:
        return "${giftMemoModel.gift.moneyAmount}+${giftMemoModel.gift.giftMoneyName}";
    }
  }

  String giftTypeToDetailsText(GiftMemoModel giftMemoModel) {
    switch (giftMemoModel.gift.gType) {
      case GiftType.gift:
        return "${giftMemoModel.gift.giftName}(x${giftMemoModel.gift.giftAmount})";
      case GiftType.both:
        return "${giftMemoModel.gift.giftName}(x${giftMemoModel.gift.giftAmount}) + ${giftMemoModel.gift.moneyAmount}(${giftMemoModel.gift.giftMoneyName})";

      default:
        return "${giftMemoModel.gift.moneyAmount}+${giftMemoModel.gift.giftMoneyName}";
    }
  }
}

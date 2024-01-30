import 'package:gift_memo/core/giftmemo_enums/gift_type.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:intl/intl.dart';

class Utils {
  String dateTimeToText(DateTime dateTime) {
    return DateFormat.yMMMd().format(dateTime);
  }

  GiftType stringToGiftType(String tName) {
    switch (tName) {
      case 'gift':
        return GiftType.gift;
      case 'money':
        return GiftType.money;
      default:
        return GiftType.both;
    }
  }

  GiftType inputAmountsToGiftType(int giftAmount, double moneyAmount) {
    if (giftAmount <= 0 && moneyAmount > 0.0) {
      return GiftType.money;
    } else if (giftAmount > 0 && moneyAmount <= 0.0) {
      return GiftType.gift;
    } else {
      return GiftType.both;
    }
  }

  GuestGender stringToGenderType(String tName) {
    switch (tName) {
      case 'male':
        return GuestGender.male;
      case 'female':
        return GuestGender.female;
      default:
        return GuestGender.other;
    }
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

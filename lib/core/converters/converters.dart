import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';

abstract class GiftMemoCoverters {}

class AmountsToTypeConverter extends GiftMemoCoverters {
  final int giftAmount;
  final double moneyAmount;

  AmountsToTypeConverter({required this.giftAmount, required this.moneyAmount});
  GiftType get inputAmountsToGiftType {
    if (giftAmount <= 0 && moneyAmount > 0.0) {
      return GiftType.money;
    } else if (giftAmount > 0 && moneyAmount <= 0.0) {
      return GiftType.gift;
    } else {
      return GiftType.both;
    }
  }
}

class MoneytoFormattedMoneyConverter extends GiftMemoCoverters {
  final double amount;

  MoneytoFormattedMoneyConverter({required this.amount});

  String get totalAmountFormatter {
    double formattedAmount = 0;
    String formattedString = '';

    if (amount.abs() >= 1000 && amount.abs() < 1000000) {
      formattedAmount = amount / 1000;
      formattedString = '${formattedAmount.toStringAsFixed(1)}K';
    } else if (amount.abs() >= 1000000 && amount.abs() < 1000000000) {
      formattedAmount = amount / 1000000;
      formattedString = '${formattedAmount.toStringAsFixed(1)}M';
    } else if (amount.abs() >= 1000000000 && amount.abs() < 1000000000000) {
      formattedAmount = amount / 1000000000;
      formattedString = '${formattedAmount.toStringAsFixed(1)}B';
    } else if (amount.abs() >= 1000000000000) {
      formattedAmount = amount / 1000000000000;
      formattedString = '${formattedAmount.toStringAsFixed(1)}T';
    } else {
      formattedString = amount.toStringAsFixed(1);
    }

    return formattedString;
  }
}

class GenderNameToGenderTypeConverter extends GiftMemoCoverters {
  final String genderName;

  GenderNameToGenderTypeConverter({required this.genderName});

  GuestGender get stringToGenderType {
    switch (genderName) {
      case 'male':
        return GuestGender.male;
      case 'female':
        return GuestGender.female;
      default:
        return GuestGender.other;
    }
  }
}

class GiftsFilterTypeToGiftListConverter extends GiftMemoCoverters {
  final List<GiftMemo> giftMemos;
  final GiftMemosFilters mType;

  GiftsFilterTypeToGiftListConverter(
      {required this.giftMemos, required this.mType});
  List<GiftMemo> get getfilterdMemo {
    switch (mType) {
      case GiftMemosFilters.gift:
        return giftMemos
            .where((element) => element.gift.gType == GiftType.gift)
            .toList();

      case GiftMemosFilters.money:
        return giftMemos
            .where((element) => element.gift.gType == GiftType.money)
            .toList();
      case GiftMemosFilters.both:
        return giftMemos
            .where((element) => element.gift.gType == GiftType.both)
            .toList();
      default:
        return giftMemos;
    }
  }
}

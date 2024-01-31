import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/gift_type.dart';
import 'package:gift_memo/core/giftmemo_enums/guests_gen.dart';
import 'package:gift_memo/core/utils/values.dart';
import 'package:gift_memo/data/models/gift.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';
import 'package:gift_memo/domain/giftmemo_manager.dart';
import 'package:gift_memo/main.dart';
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
        return "${giftMemoModel.gift.giftName} + ${giftMemoModel.gift.moneyAmount}(Tk)";

      default:
        return "${giftMemoModel.gift.moneyAmount}(Tk)";
    }
  }

  String totalAmountFormatter(double amount) {
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

  void addUpdateRecord(
      GiftMemoManager gm,
      int gAmount,
      double mAmount,
      BuildContext ctx,
      String guestName,
      String giftName,
      GuestGender gGender) {
    GiftMemoModel newMemo = GiftMemoModel(
        id: uuid.v4(),
        name: guestName,
        gift: Gift(
          giftName: giftName,
          giftAmount: gAmount,
          moneyAmount: mAmount,
          gType: Utils().inputAmountsToGiftType(gAmount, mAmount),
        ),
        gender: gGender,
        date: DateTime.now());

    (Values.currentMemoModel != null)
        ? gm.updateMemo(Values.currentMemoModel!, newMemo)
        : gm.addMemo(newMemo);
    Navigator.of(ctx).pushNamedAndRemoveUntil("/", (route) => false);
  }
}

import 'package:gift_memo/core/converters/converters.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';

class GiftMemoModel extends GiftMemo {
  const GiftMemoModel(
      {required super.id,
      required super.name,
      required super.gift,
      required super.gender,
      required super.date});

  factory GiftMemoModel.fromJson(Map<String, dynamic> json) {
    final gAmount = json['giftAmount'] as int;
    final mAmount = json['moneyAmount'] as double;
    final genderName = json['gender'] as String;
    final dateString = json['date'] as String;
    return GiftMemoModel(
        id: json['id'] as String,
        name: json['name'] as String,
        gift: Gift(
            giftName: json['giftname'] as String,
            giftAmount: gAmount,
            moneyAmount: mAmount,
            gType: AmountsToTypeConverter(
                    giftAmount: gAmount, moneyAmount: mAmount)
                .inputAmountsToGiftType),
        gender: GenderNameToGenderTypeConverter(genderName: genderName)
            .stringToGenderType,
        date: DateTime.parse(dateString));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'giftname': gift.giftName,
      'giftAmount': gift.giftAmount,
      'moneyAmount': gift.moneyAmount,
      'gender': gender.name,
      'date': date.toIso8601String(),
    };
  }

  factory GiftMemoModel.fromGiftMemo(GiftMemo giftMemo) {
    return GiftMemoModel(
      id: giftMemo.id,
      name: giftMemo.name,
      gift: giftMemo.gift,
      gender: giftMemo.gender,
      date: giftMemo.date,
    );
  }
}

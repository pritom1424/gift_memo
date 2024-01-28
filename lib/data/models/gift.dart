import 'package:gift_memo/core/giftmemo_enums/giftType.dart';

abstract class Gift {
  final String giftName;
  final String giftMoneyName;
  final int giftAmount;
  final double moneyAmount;
  final GiftType gType;

  Gift(
      {required this.giftName,
      required this.giftMoneyName,
      required this.giftAmount,
      required this.moneyAmount,
      required this.gType});
}

class WeddingGift extends Gift {
  final int amount;
  final String gName;
  WeddingGift({required this.gName, required this.amount})
      : super(
            giftName: gName,
            giftMoneyName: "",
            giftAmount: amount,
            moneyAmount: 0,
            gType: GiftType.gift);
}

class WeddingMoney extends Gift {
  final double amount;
  final String mName;
  WeddingMoney({required this.mName, required this.amount})
      : super(
            giftName: "",
            giftMoneyName: mName,
            giftAmount: 0,
            moneyAmount: amount,
            gType: GiftType.money);
}

class WeddingHybridGift extends Gift {
  final String gName;
  final String mName;
  final int gAmount;
  final double mAmount;

  WeddingHybridGift(
      {required this.gName,
      required this.mName,
      required this.gAmount,
      required this.mAmount})
      : super(
            giftName: gName,
            giftMoneyName: mName,
            giftAmount: gAmount,
            moneyAmount: mAmount,
            gType: GiftType.both);
}

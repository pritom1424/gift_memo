import 'package:gift_memo/core/giftmemo%20enums/gift_Type.dart';

abstract class Gift {
  GiftType type = GiftType.gift;
}

class WeddingGift extends Gift {
  final int amount;
  final GiftType giftType = GiftType.gift;
  WeddingGift({required this.amount});
}

class WeddingMoney extends Gift {
  final double amount;
  final GiftType giftType = GiftType.money;
  WeddingMoney({required this.amount});
}

class WeddingHybridGift extends Gift {
  final int giftAmount;
  final double moneyAmount;
  WeddingHybridGift({required this.giftAmount, required this.moneyAmount});
}

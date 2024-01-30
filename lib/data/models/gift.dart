import 'package:gift_memo/core/giftmemo_enums/gift_type.dart';

class Gift {
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

import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';

class SingleGiftCardText {
  String giftTypeToCardText(GiftMemo giftMemo) {
    switch (giftMemo.gift.gType) {
      case GiftType.gift:
        return giftMemo.gift.giftName;
      case GiftType.both:
        return "${giftMemo.gift.giftName} + ${giftMemo.gift.moneyAmount}(Tk)";

      default:
        return "${giftMemo.gift.moneyAmount}(Tk)";
    }
  }
}

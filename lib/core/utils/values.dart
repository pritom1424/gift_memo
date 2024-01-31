import 'package:gift_memo/core/giftmemo_enums/memolist_type.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';

class Values {
  static const String homeScreenRouteName = '/home-screen';
  static const String inputScreenRouteName = '/input-screen';
  static MemoListType currentMemolistType = MemoListType.all;
  static const String inavlidInputMessage =
      "Recheck valid guest name, gift title, money currency, amounts";
  static const String blankInputMessage =
      "Fix any blank guest name, gift title, money currency, amounts";
  static const String invalidValue =
      "Fix any negative or invalid gift amount, money amount";
  static GiftMemoModel? currentMemoModel;
  static String maleAvatarPath = "assets/images/male_avatar.png";
  static String femaleAvatarPath = "assets/images/female_avatar.png";
}

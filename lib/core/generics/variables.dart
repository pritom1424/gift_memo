import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/features/gift_memo/domain/entities/gift_memo.dart';

class GenericVariables {
  static GiftMemo? currentGiftMemo;
  static const String homeScreenRouteName = '/home-screen';
  static const String inputScreenRouteName = '/input-screen';
  static String maleAvatarPath = "assets/images/male_avatar.png";
  static String femaleAvatarPath = "assets/images/female_avatar.png";
  static GiftMemosFilters currentFilter = GiftMemosFilters.all;
}

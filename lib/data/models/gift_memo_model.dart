import 'package:gift_memo/core/giftmemo%20enums/guests_gen.dart';
import 'package:gift_memo/data/models/gift.dart';

class GiftMemoModel {
  final String id;
  final String name;
  final Gift gift;
  final GuestGender gender;
  final DateTime date;

  GiftMemoModel(
      {required this.id,
      required this.name,
      required this.gift,
      required this.gender,
      required this.date});
}

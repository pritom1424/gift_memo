import 'package:equatable/equatable.dart';

//entity enums
enum GuestGender {
  male,
  female,
  other;
}

enum GiftType {
  gift,
  money,
  both;
}

//entity
class GiftMemo extends Equatable {
  final String id;
  final String name;
  final Gift gift;
  final GuestGender gender;
  final DateTime date;

  const GiftMemo(
      {required this.id,
      required this.name,
      required this.gift,
      required this.gender,
      required this.date});

  @override
  List<Object?> get props => [id, name, gift, gender, date];
}

//entity subordinate class
class Gift {
  final String giftName;
  final int giftAmount;
  final double moneyAmount;
  final GiftType gType;

  Gift(
      {required this.giftName,
      required this.giftAmount,
      required this.moneyAmount,
      required this.gType});
}

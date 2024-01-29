import 'package:flutter/material.dart';
import 'package:gift_memo/core/giftmemo_enums/gift_type.dart';
import 'package:gift_memo/core/giftmemo_enums/memolist_type.dart';
import 'package:gift_memo/core/utils/utils.dart';
import 'package:gift_memo/data/RemoteHelper/firebasehelper.dart';
import 'package:gift_memo/data/models/gift.dart';
import 'package:gift_memo/data/models/gift_memo_model.dart';

class GiftMemoManager with ChangeNotifier {
  List<GiftMemoModel> _memos = [];
  List<GiftMemoModel> get getMemo => [..._memos];

  void addMemo(GiftMemoModel memo) {
    _memos.insert(0, memo);

    //db
    FireBaseHelper.insert(memo.id, {
      "id": memo.id,
      "name": memo.name,
      "giftname": memo.gift.giftName,
      "giftMoneyname": memo.gift.giftMoneyName,
      "giftAmount": memo.gift.giftAmount,
      "moneyAmount": memo.gift.moneyAmount,
      "gender": memo.gender.name,
      "date": memo.date
    });

    notifyListeners();
  }

  void removeMemo(GiftMemoModel memo) {
    _memos.removeWhere((element) => element.id == memo.id);
    FireBaseHelper.deleteData(memo.id);
    //db
    notifyListeners();
  }

  void updateMemo(String id, GiftMemoModel newMemo) {
    final modifiedMemo = GiftMemoModel(
        id: id,
        name: newMemo.name,
        gift: newMemo.gift,
        gender: newMemo.gender,
        date: newMemo.date);
    _memos[_memos.indexWhere((element) => element.id == id)] = modifiedMemo;

    FireBaseHelper.updateData(modifiedMemo.id, {
      "id": modifiedMemo.id,
      "name": modifiedMemo.name,
      "giftname": modifiedMemo.gift.giftName,
      "giftType": modifiedMemo.gift.gType.name,
      "giftMoneyname": modifiedMemo.gift.giftMoneyName,
      "giftAmount": modifiedMemo.gift.giftAmount,
      "moneyAmount": modifiedMemo.gift.moneyAmount,
      "gender": modifiedMemo.gender.name,
      "date": modifiedMemo.date
    });
    //db
    notifyListeners();
  }

  List<GiftMemoModel> getfilterdMemo(MemoListType mType) {
    switch (mType) {
      case MemoListType.gift:
        return [
          ..._memos.where((element) => element.gift.gType == GiftType.gift)
        ].toList();

      case MemoListType.money:
        return [
          ..._memos.where((element) => element.gift.gType == GiftType.money)
        ].toList();
      case MemoListType.both:
        return [
          ..._memos.where((element) => element.gift.gType == GiftType.both)
        ].toList();
      default:
        return [..._memos];
    }
  }

  Future<void> fetchMemoList() async {
    final memoSnap = await FireBaseHelper.getData();
    final memoList = memoSnap.docs.map((doc) => doc.data()).toList();

    _memos = memoList
        .map((itm) => GiftMemoModel(
            id: itm['id'].toString(),
            name: itm['name'].toString(),
            gift: Gift(
                giftName: itm['giftName'].toString(),
                giftMoneyName: itm['giftMoneyName'].toString(),
                giftAmount: itm['giftAmount'] as int,
                moneyAmount: itm['moneyAmount'] as double,
                gType: Utils().stringToGiftType(itm['giftType'].toString())),
            gender: Utils().stringToGenderType(itm['gender'].toString()),
            date: DateTime.parse(itm['date'].toString())))
        .toList()
        .reversed
        .toList();
  }
}

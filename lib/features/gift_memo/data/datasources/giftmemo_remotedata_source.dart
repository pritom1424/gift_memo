import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gift_memo/core/enums/giftmemos_filter.dart';
import 'package:gift_memo/core/errors/exceptions.dart';
import 'package:gift_memo/features/gift_memo/data/models/giftmemo_model.dart';

abstract class GiftMemoRemoteDataSource {
  Future<List<GiftMemoModel>> getGiftMemosDB(GiftMemosFilters giftMemosFilters);
  Future<void> addGiftMemoDB(GiftMemoModel newgiftMemoModel);
  Future<void> updateGiftMemoDB(String id, GiftMemoModel updateGiftMemoModel);
  Future<void> deleteGiftMemoDB(GiftMemoModel deleteGiftMemoModel);
}

class GiftMemoRemoteDataSourcesImpl extends GiftMemoRemoteDataSource {
  final String _collectionName = "guest_gifts";
  @override
  Future<void> addGiftMemoDB(GiftMemoModel newgiftMemoModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(newgiftMemoModel.id)
          .set(newgiftMemoModel.toJson());
    } catch (err) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteGiftMemoDB(GiftMemoModel deleteGiftMemoModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(deleteGiftMemoModel.id)
          .delete();
    } catch (err) {
      throw ServerException();
    }
  }

  @override
  Future<List<GiftMemoModel>> getGiftMemosDB(
      GiftMemosFilters giftMemosFilters) async {
    try {
      final giftData = await FirebaseFirestore.instance
          .collection(_collectionName)
          .orderBy('date', descending: true)
          .get();
      final giftMemosMaps = giftData.docs.map((doc) => doc.data()).toList();

      final giftMemos = giftMemosMaps.map((itm) {
        return GiftMemoModel.fromJson(itm);
      }).toList();

      return giftMemos;
    } catch (err) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateGiftMemoDB(
      String id, GiftMemoModel updateGiftMemoModel) async {
    try {
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(id)
          .update(updateGiftMemoModel.toJson());
    } catch (err) {
      throw ServerException();
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseHelper {
  static final String _collectionName = "guest_gifts";

  static Future<void> insert(String id, Map<String, dynamic> data) async {
    //login
    try {
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(id)
          .set(data);
    } catch (err) {
      print('database insert error: ${err.toString()}');
    }
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    //login
    final giftData =
        await FirebaseFirestore.instance.collection(_collectionName).get();
    return giftData;
  }

  static Future<void> deleteData(String id) async {
    //login
    try {
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(id)
          .delete();
    } catch (err) {
      print('database delete error: ${err.toString()}');
    }
  }

  static Future<void> updateData(
      String id, Map<String, dynamic> updatedData) async {
    //login
    try {
      await FirebaseFirestore.instance
          .collection(_collectionName)
          .doc(id)
          .update(updatedData);
    } catch (err) {
      print('database update error: ${err.toString()}');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/models/product_model.dart';

/// A generic Firestore service for CRUD operations on any collection.
class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> addDocument(
      String collection, Map<String, dynamic> data) async {
    final docRef = await _db.collection(collection).add(data);
    return docRef.id;
  }

  static Future<void> addDocumentsBatch(
    String collection,
    List<Map<String, dynamic>> dataList, {
    bool useCustomId = false,
  }) async {
    final batch = _db.batch();
    final colRef = _db.collection(collection);

    for (final data in dataList) {
      final docRef = useCustomId && data.containsKey('id')
          ? colRef.doc(data['id'].toString())
          : colRef.doc();
      batch.set(docRef, data);
    }

    await batch.commit();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
    String collection,
    String docId,
  ) {
    return _db.collection(collection).doc(docId).get();
  }

  static Stream<List<Map<String, dynamic>>> getCollection(String collection) {
    return _db.collection(collection).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList(),
        );
  }

  static Stream<List<ProductModel>> getProductsTyped() {
    return _db.collection('products').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
            final data = doc.data();
            return ProductModel.fromJson(data);
          }).toList(),
        );
  }

  static Future<void> updateDocument(
    String collection,
    String docId,
    Map<String, dynamic> data,
  ) {
    return _db.collection(collection).doc(docId).update(data);
  }

  static Future<void> deleteDocument(String collection, String docId) {
    return _db.collection(collection).doc(docId).delete();
  }
}

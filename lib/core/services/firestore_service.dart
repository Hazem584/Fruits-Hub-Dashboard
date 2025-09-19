import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_hub_dashboard/core/services/database_service.dart';

class FirestoreService implements DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
    } catch (e) {
      throw Exception('Failed to add data: $e');
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (documentId != null) {
        // Get single document
        DocumentSnapshot<Map<String, dynamic>> doc = await firestore
            .collection(path)
            .doc(documentId)
            .get();

        if (doc.exists) {
          final data = doc.data()!;
          data['id'] = doc.id; // إضافة الـ ID للبيانات
          return data;
        } else {
          return null;
        }
      } else {
        // Get collection with optional query
        Query<Map<String, dynamic>> collectionRef = firestore.collection(path);

        if (query != null) {
          // Apply orderBy
          if (query['orderBy'] != null) {
            final String orderByField = query['orderBy'] as String;
            final bool descending = query['descending'] as bool? ?? false;
            collectionRef = collectionRef.orderBy(
              orderByField,
              descending: descending,
            );
          }

          // Apply where clause
          if (query['where'] != null) {
            final Map<String, dynamic> whereClause =
                query['where'] as Map<String, dynamic>;
            whereClause.forEach((field, value) {
              if (value is Map &&
                  value.containsKey('operator') &&
                  value.containsKey('value')) {
                final String operator = value['operator'] as String;
                final dynamic operatorValue = value['value'];

                switch (operator) {
                  case '==':
                    collectionRef = collectionRef.where(
                      field,
                      isEqualTo: operatorValue,
                    );
                    break;
                  case '!=':
                    collectionRef = collectionRef.where(
                      field,
                      isNotEqualTo: operatorValue,
                    );
                    break;
                  case '>':
                    collectionRef = collectionRef.where(
                      field,
                      isGreaterThan: operatorValue,
                    );
                    break;
                  case '<':
                    collectionRef = collectionRef.where(
                      field,
                      isLessThan: operatorValue,
                    );
                    break;
                  case '>=':
                    collectionRef = collectionRef.where(
                      field,
                      isGreaterThanOrEqualTo: operatorValue,
                    );
                    break;
                  case '<=':
                    collectionRef = collectionRef.where(
                      field,
                      isLessThanOrEqualTo: operatorValue,
                    );
                    break;
                  case 'in':
                    collectionRef = collectionRef.where(
                      field,
                      whereIn: operatorValue,
                    );
                    break;
                  case 'not-in':
                    collectionRef = collectionRef.where(
                      field,
                      whereNotIn: operatorValue,
                    );
                    break;
                  case 'array-contains':
                    collectionRef = collectionRef.where(
                      field,
                      arrayContains: operatorValue,
                    );
                    break;
                }
              } else {
                // Simple equality check
                collectionRef = collectionRef.where(field, isEqualTo: value);
              }
            });
          }

          // Apply limit
          if (query['limit'] != null) {
            final int limit = query['limit'] as int;
            collectionRef = collectionRef.limit(limit);
          }

          // Apply startAfter for pagination
          if (query['startAfter'] != null) {
            collectionRef = collectionRef.startAfterDocument(
              query['startAfter'] as DocumentSnapshot,
            );
          }
        }

        QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionRef
            .get();

        // Debug: طباعة عدد النتائج
        print('Number of documents fetched: ${querySnapshot.docs.length}');

        final List<Map<String, dynamic>> results = querySnapshot.docs.map((
          doc,
        ) {
          final data = doc.data();
          data['id'] = doc.id; // Add document ID to the data

          // Debug: طباعة البيانات
          print('Document data: $data');

          return data;
        }).toList();

        print('Final results count: ${results.length}');
        return results;
      }
    } catch (e) {
      print('Error in getData: $e'); // Debug
      throw Exception('Failed to get data: $e');
    }
  }

  @override
  Future<bool> checkIfDocumentExists({
    required String path,
    required String documentId,
  }) async {
    try {
      DocumentSnapshot doc = await firestore
          .collection(path)
          .doc(documentId)
          .get();
      return doc.exists;
    } catch (e) {
      throw Exception('Failed to check document existence: $e');
    }
  }

  // Additional useful methods you might want to add:

  /// Update specific fields in a document
  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await firestore.collection(path).doc(documentId).update(data);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  /// Delete a document
  Future<void> deleteData({
    required String path,
    required String documentId,
  }) async {
    try {
      await firestore.collection(path).doc(documentId).delete();
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }

  /// Get real-time updates for a document
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream({
    required String path,
    required String documentId,
  }) {
    return firestore.collection(path).doc(documentId).snapshots();
  }

  /// Get real-time updates for a collection
  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionStream({
    required String path,
    Map<String, dynamic>? query,
  }) {
    Query<Map<String, dynamic>> collectionRef = firestore.collection(path);

    if (query != null) {
      // Apply the same query logic as in getData
      if (query['orderBy'] != null) {
        final String orderByField = query['orderBy'] as String;
        final bool descending = query['descending'] as bool? ?? false;
        collectionRef = collectionRef.orderBy(
          orderByField,
          descending: descending,
        );
      }

      if (query['limit'] != null) {
        final int limit = query['limit'] as int;
        collectionRef = collectionRef.limit(limit);
      }
    }

    return collectionRef.snapshots();
  }
}

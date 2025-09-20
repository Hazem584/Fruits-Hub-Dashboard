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
      // 🔧 إصلاح: تحليل المسار إذا كان يحتوي على collection/document
      if (path.contains('/') && documentId == null) {
        // تحليل المسار: orders/documentId
        final pathParts = path.split('/');
        if (pathParts.length == 2) {
          final collectionPath = pathParts[0];
          final docId = pathParts[1];
          print('Parsed path - Collection: $collectionPath, Document: $docId');
          return await _getSingleDocument(collectionPath, docId);
        } else {
          throw Exception('Invalid path format: $path');
        }
      }
      
      if (documentId != null) {
        return await _getSingleDocument(path, documentId);
      } else {
        return await _getCollection(path, query);
      }
    } catch (e) {
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

  @override
  Stream<List<Map<String, dynamic>>> streamData({
    required String path,
    Map<String, dynamic>? query,
  }) {
    try {
      Query<Map<String, dynamic>> collectionRef = firestore.collection(path);

      if (query != null) {
        collectionRef = _applyQueryFilters(collectionRef, query);
      }

      return collectionRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
      });
    } catch (e) {
      return Stream.error(Exception('Failed to stream data: $e'));
    }
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      print('🔧 UpdateData called with:');
      print('Path: $path');
      print('DocumentId: $documentId');
      print('Data: $data');
      
      // 🔧 إصلاح: تحليل المسار إذا كان يحتوي على collection/document
      if (path.contains('/') && documentId == null) {
        final pathParts = path.split('/');
        if (pathParts.length == 2) {
          final collectionPath = pathParts[0];
          final docId = pathParts[1];
          print('Parsed - Collection: $collectionPath, Document: $docId');
          await firestore.collection(collectionPath).doc(docId).update(data);
          return;
        } else {
          throw Exception('Invalid path format: $path');
        }
      }
      
      // الطريقة التقليدية
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).update(data);
      } else {
        throw Exception('Document ID is required for update operation');
      }
    } catch (e) {
      print('UpdateData error: $e');
      throw Exception('Failed to update data: $e');
    }
  }

  // إضافة setData method
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
    bool merge = false,
  }) async {
    try {
      print('🔧 SetData called with:');
      print('Path: $path');
      print('DocumentId: $documentId');
      print('Merge: $merge');
      
      if (documentId != null) {
        await firestore
            .collection(path)
            .doc(documentId)
            .set(data, SetOptions(merge: merge));
      } else {
        await firestore.collection(path).add(data);
      }
    } catch (e) {
      print('SetData error: $e');
      throw Exception('Failed to set data: $e');
    }
  }

  // ========== دوال مساعدة خاصة ==========

  /// الحصول على مستند واحد
  Future<Map<String, dynamic>?> _getSingleDocument(
    String path,
    String documentId,
  ) async {
    print('Getting single document - Collection: $path, Doc: $documentId');
    DocumentSnapshot<Map<String, dynamic>> doc = await firestore
        .collection(path)
        .doc(documentId)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      data['id'] = doc.id;
      print('Document found with data keys: ${data.keys.toList()}');
      return data;
    }
    print('Document not found');
    return null;
  }

  /// الحصول على مجموعة من المستندات
  Future<List<Map<String, dynamic>>> _getCollection(
    String path,
    Map<String, dynamic>? query,
  ) async {
    Query<Map<String, dynamic>> collectionRef = firestore.collection(path);

    if (query != null) {
      collectionRef = _applyQueryFilters(collectionRef, query);
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionRef
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  /// تطبيق فلاتر الاستعلام
  Query<Map<String, dynamic>> _applyQueryFilters(
    Query<Map<String, dynamic>> collectionRef,
    Map<String, dynamic> query,
  ) {
    // تطبيق orderBy
    if (query['orderBy'] != null) {
      final String orderByField = query['orderBy'] as String;
      final bool descending = query['descending'] as bool? ?? false;
      collectionRef = collectionRef.orderBy(
        orderByField,
        descending: descending,
      );
    }

    // تطبيق where clause
    if (query['where'] != null) {
      final Map<String, dynamic> whereClause =
          query['where'] as Map<String, dynamic>;
      collectionRef = _applyWhereClause(collectionRef, whereClause);
    }

    // تطبيق limit
    if (query['limit'] != null) {
      final int limit = query['limit'] as int;
      collectionRef = collectionRef.limit(limit);
    }

    // تطبيق startAfter للتقسيم
    if (query['startAfter'] != null) {
      collectionRef = collectionRef.startAfterDocument(
        query['startAfter'] as DocumentSnapshot,
      );
    }

    return collectionRef;
  }

  /// تطبيق شروط Where
  Query<Map<String, dynamic>> _applyWhereClause(
    Query<Map<String, dynamic>> collectionRef,
    Map<String, dynamic> whereClause,
  ) {
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
            collectionRef = collectionRef.where(field, whereIn: operatorValue);
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
          case 'array-contains-any':
            collectionRef = collectionRef.where(
              field,
              arrayContainsAny: operatorValue,
            );
            break;
          default:
            throw ArgumentError('Unsupported operator: $operator');
        }
      } else {
        collectionRef = collectionRef.where(field, isEqualTo: value);
      }
    });

    return collectionRef;
  }

  /// حذف مستند
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

  /// الحصول على stream لمستند واحد
  Stream<DocumentSnapshot<Map<String, dynamic>>> getDocumentStream({
    required String path,
    required String documentId,
  }) {
    return firestore.collection(path).doc(documentId).snapshots();
  }
}
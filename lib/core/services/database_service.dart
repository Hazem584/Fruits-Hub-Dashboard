abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? query,
  });

  Stream<List<Map<String, dynamic>>> streamData({
    required String path,
    Map<String, dynamic>? query,
  });

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  // ✅ إضافة setData method
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
    bool merge = false,
  });

  Future<bool> checkIfDocumentExists({
    required String path,
    required String documentId,
  });

  // طرق إضافية مفيدة
  Future<void> deleteData({
    required String path,
    required String documentId,
  });
}
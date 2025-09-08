import 'dart:io';

import 'package:fruits_hub_dashboard/core/services/storage_service.dart';
import 'package:fruits_hub_dashboard/core/utils/constants.dart';
import 'package:path/path.dart' as b;
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageServices implements StorageService {
  static late Supabase _supabase;

  static createBucket(String bucketName) async {
    try {
      var buckets = await _supabase.client.storage.listBuckets();
      bool isBucketExist = false;
      for (var bucket in buckets) {
        if (bucket.name == bucketName) {
          isBucketExist = true;
          break;
        }
      }
      if (!isBucketExist) {
        await _supabase.client.storage.createBucket(
          bucketName,
          const BucketOptions(public: true),
        );
      }
    } catch (e) {
      print('Error creating bucket: $e');
      rethrow;
    }
  }

  static initSupabase() async {
    try {
      _supabase = await Supabase.initialize(
        url: kSupabaseUrl,
        anonKey: kSupabaseAnonKey,
      );
    } catch (e) {
      print('Error initializing Supabase: $e');
      rethrow;
    }
  }

  @override
  Future<String> uploadFile(File file, String path) async {
    try {
      final fileBytes = await file.readAsBytes();
      String fileName = b.basenameWithoutExtension(file.path);
      String extensionName = b.extension(file.path);
      String uniqueFileName =
          '${fileName}_${DateTime.now().millisecondsSinceEpoch}$extensionName';
      String fullPath = '$path/$uniqueFileName';
      await _supabase.client.storage
          .from('fruits_images')
          .uploadBinary(
            fullPath,
            fileBytes,
            fileOptions: FileOptions(
              contentType: _getContentType(extensionName),
              upsert: true,
            ),
          );
      final String publicUrl = _supabase.client.storage
          .from('fruits_images')
          .getPublicUrl(fullPath);

      return publicUrl;
    } catch (e) {
      print('Error uploading file: $e');
      rethrow;
    }
  }

  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case '.jpg':
      case '.jpeg':
        return 'image/jpeg';
      case '.png':
        return 'image/png';
      case '.gif':
        return 'image/gif';
      case '.webp':
        return 'image/webp';
      case '.svg':
        return 'image/svg+xml';
      default:
        return 'application/octet-stream';
    }
  }
}

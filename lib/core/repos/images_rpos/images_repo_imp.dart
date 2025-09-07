import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/core/errors/failures.dart';
import 'package:fruits_hub_dashboard/core/repos/images_rpos/images_repo.dart';
import 'package:fruits_hub_dashboard/core/services/storage_service.dart';
import 'package:fruits_hub_dashboard/core/utils/backend_endpoint.dart';

class ImagesRepoImp implements ImagesRepo {
  final StorageService storageService;
  ImagesRepoImp({required this.storageService});

  @override
  Future<Either<Failure, String>> uploadImage(File imagePath) async {
    try {
      String url = await storageService.uploadFile(
        imagePath,
        BackendEndpoint.images,
      );
      return Right(url);
    } catch (e) {
      return Left(ServerFailure("Failed to upload image"));
    }
  }
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboaerd/core/errors/failures.dart';
import 'package:fruits_hub_dashboaerd/core/repos/images_rpos/images_repo.dart';

class ImagesRepoImp implements ImagesRepo {
  @override
  Future<Either<Failure, String>> uploadImage(File imagePath) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }
}

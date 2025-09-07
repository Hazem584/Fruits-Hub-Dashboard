import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboaerd/core/errors/failures.dart';

abstract class ImagesRepo {
  Future<Either<Failure, String>> uploadImage(File imagePath);
}

import 'package:fruits_hub_dashboard/core/repos/images_rpos/images_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/images_rpos/images_repo_imp.dart';
import 'package:fruits_hub_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/product_repo/products_repo_imp.dart';
import 'package:fruits_hub_dashboard/core/services/fire_storage.dart';
import 'package:fruits_hub_dashboard/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerLazySingleton<StorageService>(() => FireStorage());
  getIt.registerLazySingleton<ImagesRepo>(
    () => ImagesRepoImp(storageService: getIt.get<StorageService>()),
  );
  getIt.registerLazySingleton<ProductRepo>(() => ProductsRepoImp());
}

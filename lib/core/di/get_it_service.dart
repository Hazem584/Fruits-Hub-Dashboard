import 'package:fruits_hub_dashboard/core/repos/images_rpos/images_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/images_rpos/images_repo_imp.dart';
import 'package:fruits_hub_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/product_repo/products_repo_imp.dart';
import 'package:fruits_hub_dashboard/core/services/database_service.dart';
import 'package:fruits_hub_dashboard/core/services/firestore_service.dart';
import 'package:fruits_hub_dashboard/core/services/storage_service.dart';
import 'package:fruits_hub_dashboard/core/services/supabase_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerLazySingleton<StorageService>(() => SupabaseStorageServices());
  getIt.registerLazySingleton<ImagesRepo>(
    () => ImagesRepoImp(storageService: getIt.get<StorageService>()),
  );
  getIt.registerLazySingleton<DatabaseService>(() => FirestoreService());
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductsRepoImp(databaseService: getIt.get<DatabaseService>()),
  );
}

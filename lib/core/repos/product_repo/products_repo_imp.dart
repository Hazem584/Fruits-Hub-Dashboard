import 'package:dartz/dartz.dart';
import 'package:fruits_hub_dashboard/core/errors/failures.dart';
import 'package:fruits_hub_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:fruits_hub_dashboard/core/services/database_service.dart';
import 'package:fruits_hub_dashboard/core/utils/backend_endpoint.dart';
import 'package:fruits_hub_dashboard/features/add_product/data/models/add_product_iput_model.dart';
import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_input_entity.dart';

class ProductsRepoImp implements ProductRepo {
  final DatabaseService databaseService;

  ProductsRepoImp({required this.databaseService});
  @override
  Future<Either<Failure, void>> addProduct(
    AddProductInputEntity addProductInputEntity,
  ) async {
    try {
      await databaseService.addData(
        path: BackendEndpoint.addProducts,
        data: AddProductInputModel.fromEntity(addProductInputEntity).toJson(),
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

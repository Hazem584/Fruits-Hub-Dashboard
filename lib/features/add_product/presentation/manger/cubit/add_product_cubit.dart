import 'package:bloc/bloc.dart';
import 'package:fruits_hub_dashboard/core/repos/images_rpos/images_repo.dart';
import 'package:fruits_hub_dashboard/core/repos/product_repo/product_repo.dart';
import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_input_entity.dart';
import 'package:meta/meta.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.imagesRepo, this.productRepo)
    : super(AddProductInitial());

  final ImagesRepo imagesRepo;
  final ProductRepo productRepo;

  Future<void> addProduct(AddProductInputEntity addProductInputEntity) async {
    emit(AddProductLoading());

    var result = await imagesRepo.uploadImage(addProductInputEntity.imagePath);

    result.fold(
      (failure) {
        emit(AddProductFailure(failure.message));
      },
      (url) async {
        var updatedEntity = addProductInputEntity.copyWith(imageUrl: url);
        var res = await productRepo.addProduct(updatedEntity);
        res.fold(
          (failure) => emit(AddProductFailure(failure.message)),
          (success) => emit(AddProductSuccess()),
        );
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_orders_state.dart';

class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  FetchOrdersCubit(this.ordersRepo) : super(FetchOrdersInitial());
  final OrdersRepo ordersRepo;

  Future<void> getOrders() async {
    emit(FetchOrdersLoading());
    final result = await ordersRepo.getOrders();
    result.fold(
      (error) => emit(FetchOrdersFailure(message: error.message)),
      (orders) => emit(FetchOrdersSuccess(orders: orders)),
    );
  }
}

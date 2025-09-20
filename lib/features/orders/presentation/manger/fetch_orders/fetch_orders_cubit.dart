import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_orders_state.dart';

class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  FetchOrdersCubit(this.ordersRepo) : super(FetchOrdersInitial());
  final OrdersRepo ordersRepo;
  StreamSubscription? ordersSubscription;
  void getOrders() {
    emit(FetchOrdersLoading());
    ordersSubscription = ordersRepo.getOrders().listen((results) {
      results.fold(
        (f) {
          emit(FetchOrdersFailure(message: f.message));
        },
        (orders) {
          emit(FetchOrdersSuccess(orders: orders));
        },
      );
    });
  }

  @override
  Future<void> close() {
    ordersSubscription?.cancel();
    return super.close();
  }
}

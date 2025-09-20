import 'package:bloc/bloc.dart';
import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:meta/meta.dart';

part 'update_order_state.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderState> {
  UpdateOrderCubit(this.ordersRepo) : super(UpdateOrderInitial());
  final OrdersRepo ordersRepo;

  Future<void> updateOrderStatus({
    required OrderStatusEnum status,
    required String orderId,
  }) async {
    print('🔄 UpdateOrderCubit: Starting update...');
    print('Order ID: $orderId');
    print('New Status: ${status.name}');

    emit(UpdateOrderLoading());

    final result = await ordersRepo.updateOrderStatus(
      status: status,
      orderId: orderId,
    );

    result.fold(
      (failure) {
        print('❌ UpdateOrderCubit: Error - ${failure.message}');
        emit(UpdateOrderError(message: failure.message));
      },
      (_) {
        print('✅ UpdateOrderCubit: Success');
        emit(UpdateOrderSuccess());
      },
    );
  }

  // دالة للتحقق من صحة البيانات قبل التحديث
  bool _validateOrderUpdate({
    required OrderStatusEnum currentStatus,
    required OrderStatusEnum newStatus,
  }) {
    // منع التحديث إلى نفس الحالة
    if (currentStatus == newStatus) {
      return false;
    }

    // التحقق من منطقية التسلسل
    switch (currentStatus) {
      case OrderStatusEnum.pending:
        return [
          OrderStatusEnum.accepted,
          OrderStatusEnum.cancelled,
        ].contains(newStatus);
      case OrderStatusEnum.accepted:
        return [
          OrderStatusEnum.shipped,
          OrderStatusEnum.cancelled,
        ].contains(newStatus);
      case OrderStatusEnum.shipped:
        return [OrderStatusEnum.delivered].contains(newStatus);
      case OrderStatusEnum.delivered:
      case OrderStatusEnum.cancelled:
        return false; // لا يمكن تغيير الحالات النهائية
    }
  }

  Future<void> updateOrderStatusWithValidation({
    required OrderStatusEnum currentStatus,
    required OrderStatusEnum newStatus,
    required String orderId,
  }) async {
    if (!_validateOrderUpdate(
      currentStatus: currentStatus,
      newStatus: newStatus,
    )) {
      emit(
        UpdateOrderError(
          message:
              'Cannot update order from ${currentStatus.displayName} to ${newStatus.displayName}',
        ),
      );
      return;
    }

    await updateOrderStatus(status: newStatus, orderId: orderId);
  }
}

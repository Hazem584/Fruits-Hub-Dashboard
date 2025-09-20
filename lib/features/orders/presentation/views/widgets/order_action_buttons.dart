import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/manger/update_orders/update_order_cubit.dart';
import '../../../../../core/enums/order_enum.dart';

class OrderActionButtons extends StatelessWidget {
  const OrderActionButtons({super.key, required this.orderModel});

  final OrderEntity orderModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // زر القبول
        Visibility(
          visible: orderModel.status == OrderStatusEnum.pending,
          child: ElevatedButton(
            onPressed: () {
              // ✅ تمرير الحالة الجديدة والـ orderID الصحيح
              context.read<UpdateOrderCubit>().updateOrderStatus(
                status: OrderStatusEnum.accepted, // الحالة الجديدة
                orderId: orderModel.orderID, // الـ ID الصحيح
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('قبول'),
          ),
        ),

        // زر الرفض
        Visibility(
          visible: orderModel.status == OrderStatusEnum.pending,
          child: ElevatedButton(
            onPressed: () {
              context.read<UpdateOrderCubit>().updateOrderStatus(
                status: OrderStatusEnum.cancelled, // الحالة الجديدة
                orderId: orderModel.orderID,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('رفض'),
          ),
        ),

        // زر الشحن
        Visibility(
          visible: orderModel.status == OrderStatusEnum.accepted,
          child: ElevatedButton(
            onPressed: () {
              context.read<UpdateOrderCubit>().updateOrderStatus(
                status: OrderStatusEnum.shipped, // الحالة الجديدة
                orderId: orderModel.orderID,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('شحن'),
          ),
        ),

        // زر التسليم
        Visibility(
          visible: orderModel.status == OrderStatusEnum.shipped,
          child: ElevatedButton(
            onPressed: () {
              context.read<UpdateOrderCubit>().updateOrderStatus(
                status: OrderStatusEnum.delivered, // الحالة الجديدة
                orderId: orderModel.orderID,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            child: const Text('تم التسليم'),
          ),
        ),
      ],
    );
  }
}

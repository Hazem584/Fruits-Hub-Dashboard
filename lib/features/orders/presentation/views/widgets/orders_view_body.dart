import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/helper/get_order_dummy_date.dart';
import 'package:fruits_hub_dashboard/core/helper/spacing.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/views/widgets/filter_section.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/views/widgets/orders_itemes_list_view.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key, required this.orderEntity});
  final List<OrderEntity> orderEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const FilterSection(),
          verticalSpace(16),
          Expanded(child: OrdersItemsListView(orderEntity: orderEntity)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub_dashboard/core/di/get_it_service.dart';
import 'package:fruits_hub_dashboard/core/helper/get_order_dummy_date.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/repos/orders_repo.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/manger/fetch_orders/fetch_orders_cubit.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/manger/update_orders/update_order_cubit.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/views/widgets/orders_view_body.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/views/widgets/update_order_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});
  static const routeName = 'orders';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchOrdersCubit>(
          create: (context) => FetchOrdersCubit(getIt.get<OrdersRepo>()),
        ),
        BlocProvider<UpdateOrderCubit>(
          create: (context) => UpdateOrderCubit(getIt.get<OrdersRepo>()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.white,
        ),
        body: const UpdateOrderBuilder(child: OrdersViewBodyBlocBuilder()),
      ),
    );
  }
}

class OrdersViewBodyBlocBuilder extends StatefulWidget {
  const OrdersViewBodyBlocBuilder({super.key});

  @override
  State<OrdersViewBodyBlocBuilder> createState() =>
      _OrdersViewBodyBlocBuilderState();
}

class _OrdersViewBodyBlocBuilderState extends State<OrdersViewBodyBlocBuilder> {
  @override
  void initState() {
    context.read<FetchOrdersCubit>().getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchOrdersCubit, FetchOrdersState>(
      builder: (context, state) {
        if (state is FetchOrdersSuccess) {
          return OrdersViewBody(orderEntity: state.orders);
        } else if (state is FetchOrdersFailure) {
          return Center(child: Text(state.message));
        } else {
          return Skeletonizer(
            child: OrdersViewBody(
              orderEntity: [getOrderDummyDate(), getOrderDummyDate()],
            ),
          );
        }
      },
    );
  }
}

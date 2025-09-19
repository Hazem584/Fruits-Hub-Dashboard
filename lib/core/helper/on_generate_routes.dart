import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/features/add_product/presentation/view/add_product_view.dart';
import 'package:fruits_hub_dashboard/features/dashboard/views/dashboard_view.dart';
import 'package:fruits_hub_dashboard/features/orders/presentation/views/orders_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case DashboardView.routeName:
      return MaterialPageRoute(builder: (_) => const DashboardView());
    case AddProductView.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductView());
    case OrdersView.routeName:
      return MaterialPageRoute(builder: (_) => const OrdersView());
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold());
  }
}

import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_product_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

class OrderEntity {
  final double totalPrice;
  final String uId;
  final ShippingAddressEntity shippingAddress;
  final List<OrderProductEntity> orderProductModels;
  final String paymentMethod;
  final OrderEnum? status; 

  OrderEntity({
    required this.totalPrice,
    required this.status,
    required this.uId,
    required this.shippingAddress,
    required this.orderProductModels,
    required this.paymentMethod,
  });
}

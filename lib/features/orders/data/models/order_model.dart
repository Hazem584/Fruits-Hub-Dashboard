import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';
import 'package:fruits_hub_dashboard/features/orders/data/models/order_product_model.dart';
import 'package:fruits_hub_dashboard/features/orders/data/models/shipping_address_model.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_product_entity.dart';

class OrderModel {
  final double totalPrice;
  final String uId;
  final ShippingAddressModel shippingAddress;
  final List<OrderProductModel> orderProductModels;
  final String paymentMethod;
  final OrderEnum? status;

  OrderModel({
    required this.status,
    required this.totalPrice,
    required this.uId,
    required this.shippingAddress,
    required this.orderProductModels,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    // ✅ الطريقة الآمنة لتحويل String إلى Enum
    status: _stringToOrderEnum(json['status']),
    totalPrice: json['totalPrice'].toDouble(),
    uId: json['uId'],
    shippingAddress: ShippingAddressModel.fromJson(
      json['shippingAddressModel'],
    ),
    orderProductModels: List<OrderProductModel>.from(
      json['orderProductModels'].map((x) => OrderProductModel.fromJson(x)),
    ),
    paymentMethod: json['paymentMethod'],
  );

  // ✅ دالة مساعدة لتحويل String إلى OrderEnum بشكل آمن
  static OrderEnum? _stringToOrderEnum(dynamic value) {
    if (value == null) return OrderEnum.pending;

    String statusString = value.toString().toLowerCase();

    try {
      return OrderEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == statusString,
        orElse: () => OrderEnum.pending, // ✅ قيمة افتراضية
      );
    } catch (e) {
      return OrderEnum.pending;
    }
  }

  toJson() => {
    'totalPrice': totalPrice,
    'uId': uId,
    'status': status?.name ?? 'pending', // ✅ استخدام .name بدلاً من toString()
    'date': DateTime.now().toString(),
    'shippingAddressModel': shippingAddress.toJson(),
    'orderProductModels': orderProductModels.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };

  OrderEntity toEntity() => OrderEntity(
    totalPrice: totalPrice,
    status: status ?? OrderEnum.pending, // ✅ قيمة افتراضية بسيطة
    uId: uId,
    shippingAddress: shippingAddress.toEntity(),
    orderProductModels: orderProductModels
        .map<OrderProductEntity>((e) => e.toEntity())
        .toList(),
    paymentMethod: paymentMethod,
  );
}

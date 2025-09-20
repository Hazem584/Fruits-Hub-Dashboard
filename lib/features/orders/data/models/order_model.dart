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
  final OrderStatusEnum status;
  final String orderId;

  OrderModel({
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.uId,
    required this.shippingAddress,
    required this.orderProductModels,
    required this.paymentMethod,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderModel(
        status: _stringToOrderEnum(json['status']) ?? OrderStatusEnum.pending,
        totalPrice: _safeDoubleConversion(json['totalPrice']),
        uId: json['uId']?.toString() ?? '',
        orderId: json['orderId']?.toString() ?? '',
        shippingAddress: ShippingAddressModel.fromJson(
          json['shippingAddressModel'] ?? {},
        ),
        orderProductModels: _parseOrderProducts(json['orderProductModels']),
        paymentMethod: json['paymentMethod']?.toString() ?? '',
      );
    } catch (e) {
      print('Error parsing OrderModel from JSON: $e');
      rethrow;
    }
  }

  // ✅ دالة مساعدة لتحويل List الخاص بالمنتجات
  static List<OrderProductModel> _parseOrderProducts(dynamic productsJson) {
    if (productsJson == null) return <OrderProductModel>[];

    if (productsJson is! List) return <OrderProductModel>[];

    try {
      return productsJson
          .map<OrderProductModel>((json) => OrderProductModel.fromJson(json))
          .toList();
    } catch (e) {
      print('Error parsing order products: $e');
      return <OrderProductModel>[];
    }
  }

  // ✅ دالة مساعدة آمنة لتحويل إلى double
  static double _safeDoubleConversion(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }

  // ✅ دالة مساعدة لتحويل String إلى OrderEnum بشكل آمن
  static OrderStatusEnum? _stringToOrderEnum(dynamic value) {
    if (value == null) return null;

    String statusString = value.toString().toLowerCase().trim();

    try {
      return OrderStatusEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == statusString,
        orElse: () => OrderStatusEnum.pending,
      );
    } catch (e) {
      print('Failed to parse order status: $value');
      return OrderStatusEnum.pending;
    }
  }

  Map<String, dynamic> toJson() => {
    'totalPrice': totalPrice,
    'uId': uId,
    'orderId': orderId,
    'status': status.name,
    'date': DateTime.now().toIso8601String(),
    'shippingAddressModel': shippingAddress.toJson(),
    'orderProductModels': orderProductModels.map((e) => e.toJson()).toList(),
    'paymentMethod': paymentMethod,
  };

  OrderEntity toEntity() => OrderEntity(
    orderID: orderId,
    totalPrice: totalPrice,
    status: status,
    uId: uId,
    shippingAddress: shippingAddress.toEntity(),
    orderProductModels: orderProductModels
        .map<OrderProductEntity>((e) => e.toEntity())
        .toList(),
    paymentMethod: paymentMethod,
  );

  // Copy with method
  OrderModel copyWith({
    String? orderId,
    double? totalPrice,
    String? uId,
    ShippingAddressModel? shippingAddress,
    List<OrderProductModel>? orderProductModels,
    String? paymentMethod,
    OrderStatusEnum? status,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      totalPrice: totalPrice ?? this.totalPrice,
      uId: uId ?? this.uId,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      orderProductModels: orderProductModels ?? this.orderProductModels,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'OrderModel{orderId: $orderId, totalPrice: $totalPrice, status: ${status.name}}';
  }
}

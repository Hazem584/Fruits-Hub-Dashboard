import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_product_entity.dart';

class OrderProductModel {
  final String name;
  final String code;
  final String imageUrl;
  final int quantity;
  final double price;

  OrderProductModel({
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      name: json['name']?.toString() ?? '',
      code: json['code']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      quantity: _safeIntConversion(json['quantity']),
      price: _safeDoubleConversion(json['price']),
    );
  }
  static int _safeIntConversion(dynamic value) {
    if (value == null) return 0;

    if (value is int) return value;

    if (value is double) return value.toInt();

    if (value is String) {
      return int.tryParse(value) ?? 0;
    }

    return 0;
  }

  static double _safeDoubleConversion(dynamic value) {
    if (value == null) return 0.0;

    if (value is double) return value;

    if (value is int) return value.toDouble();

    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
    };
  }

  OrderProductEntity toEntity() {
    return OrderProductEntity(
      name: name,
      code: code,
      imageUrl: imageUrl,
      quantity: quantity,
      price: price,
    );
  }
}

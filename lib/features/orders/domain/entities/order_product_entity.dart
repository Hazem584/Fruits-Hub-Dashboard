class OrderProductEntity {
  final String name;
  final String code;
  final String imageUrl;
  final int quantity;
  final double price;

  OrderProductEntity({
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  // Factory constructor مع معالجة القيم المحتملة null
  factory OrderProductEntity.fromValues({
    String? name,
    String? code,
    String? imageUrl,
    int? quantity,
    double? price,
  }) {
    return OrderProductEntity(
      name: name ?? '',
      code: code ?? '',
      imageUrl: imageUrl ?? '',
      quantity: quantity ?? 0,
      price: price ?? 0.0,
    );
  }

  // Copy with method
  OrderProductEntity copyWith({
    String? name,
    String? code,
    String? imageUrl,
    int? quantity,
    double? price,
  }) {
    return OrderProductEntity(
      name: name ?? this.name,
      code: code ?? this.code,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  // حساب السعر الإجمالي للمنتج
  double get totalPrice => price * quantity;

  @override
  String toString() {
    return 'OrderProductEntity{name: $name, code: $code, quantity: $quantity, price: $price}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OrderProductEntity &&
        other.name == name &&
        other.code == code &&
        other.imageUrl == imageUrl &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        code.hashCode ^
        imageUrl.hashCode ^
        quantity.hashCode ^
        price.hashCode;
  }
}
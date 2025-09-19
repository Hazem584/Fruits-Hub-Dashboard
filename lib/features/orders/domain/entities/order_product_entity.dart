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
}

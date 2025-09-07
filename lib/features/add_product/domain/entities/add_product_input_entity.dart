import 'dart:io';

class AddProductInputEntity {
  final String name;
  final String description;
  final String? imageUrl;
  final String code;
  final bool isFeatured;
  final File imagePath;
  final num price;

  AddProductInputEntity({
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.code,
    required this.isFeatured,
    required this.imagePath,
  });
}

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
  AddProductInputEntity copyWith({
    String? name,
    String? description,
    String? imageUrl,
    String? code,
    bool? isFeatured,
    File? imagePath,
    num? price,
  }) {
    return AddProductInputEntity(
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      code: code ?? this.code,
      isFeatured: isFeatured ?? this.isFeatured,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
    );
  }
}

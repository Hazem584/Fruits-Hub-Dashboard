import 'dart:io';

import 'package:fruits_hub_dashboard/features/add_product/domain/entities/add_product_input_entity.dart';

class AddProductInputModel {
  final String name;
  final String description;
  final String? imageUrl;
  final String code;
  final bool isFeatured;
  final File imagePath;
  final num price;

  AddProductInputModel({
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.code,
    required this.isFeatured,
    required this.imagePath,
  });

  factory AddProductInputModel.fromEntity(
    AddProductInputEntity addProductInputEntity,
  ) {
    return AddProductInputModel(
      name: addProductInputEntity.name,
      description: addProductInputEntity.description,
      price: addProductInputEntity.price,
      imageUrl: addProductInputEntity.imageUrl,
      code: addProductInputEntity.code,
      isFeatured: addProductInputEntity.isFeatured,
      imagePath: addProductInputEntity.imagePath,
    );
  }
  toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "code": code,
      "isFeatured": isFeatured,
      "price": price,
    };
  }
}

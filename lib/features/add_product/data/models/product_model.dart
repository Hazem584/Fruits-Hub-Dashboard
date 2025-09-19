import 'dart:io';

import 'package:fruits_hub_dashboard/features/add_product/data/models/review_model.dart';
import 'package:fruits_hub_dashboard/features/add_product/domain/entities/product_entity.dart';

class ProductModel {
  final String name;
  final String description;
  final String? imageUrl;
  final String code;
  final bool isFeatured;
  final File imagePath;
  final num price;
  final int expirationMonths;
  final bool isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRating = 0;
  final num ratingCounts = 0;
  final List<ReviewModel> reviews;
  final int sellingCount;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.code,
    required this.isFeatured,
    required this.imagePath,
    required this.expirationMonths,
    required this.numberOfCalories,
    required this.unitAmount,
    this.isOrganic = false,
    required this.reviews,
    this.sellingCount = 0,
  });

  factory ProductModel.fromEntity(ProductEntity addProductInputEntity) {
    return ProductModel(
      name: addProductInputEntity.name,
      description: addProductInputEntity.description,
      price: addProductInputEntity.price,
      imageUrl: addProductInputEntity.imageUrl,
      code: addProductInputEntity.code,
      isFeatured: addProductInputEntity.isFeatured,
      imagePath: addProductInputEntity.imagePath,
      expirationMonths: addProductInputEntity.expirationMonths,
      numberOfCalories: addProductInputEntity.numberOfCalories,
      unitAmount: addProductInputEntity.unitAmount,
      isOrganic: addProductInputEntity.isOrganic,
      reviews: addProductInputEntity.reviews
          .map((review) => ReviewModel.fromEntity(review))
          .toList(),
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
      "expirationMonths": expirationMonths,
      "isOrganic": isOrganic,
      "numberOfCalories": numberOfCalories,
      "unitAmount": unitAmount,
      "avgRating": avgRating,
      "ratingCounts": ratingCounts,
      "reviews": reviews.map((review) => review.toJson()).toList(),
      "sellingCount": sellingCount,
    };
  }
}

import 'package:fruits_hub_dashboard/features/add_product/domain/entities/review_entity.dart';

class ReviewModel {
  final String name;
  final String image;
  final num rating;
  final String reviewDescription;
  final DateTime date;

  ReviewModel({
    required this.name,
    required this.image,
    required this.rating,
    required this.reviewDescription,
    required this.date,
  });

  factory ReviewModel.fromEntity(ReviewEntity entity) {
    return ReviewModel(
      name: entity.name,
      image: entity.image,
      rating: entity.rating,
      reviewDescription: entity.reviewDescription,
      date: entity.date,
    );
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['name'],
      image: json['image'],
      rating: json['rating'],
      reviewDescription: json['reviewDescription'],
      date: DateTime.parse(json['date']),
    );
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'rating': rating,
      'reviewDescription': reviewDescription,
      'date': date,
    };
  }
}

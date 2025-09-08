class ReviewEntity {
  final String name;
  final String image;
  final num rating;
  final String reviewDescription;
  final DateTime date;

  ReviewEntity({
    required this.name,
    required this.image,
    required this.rating,
    required this.reviewDescription,
    required this.date,
  });
}

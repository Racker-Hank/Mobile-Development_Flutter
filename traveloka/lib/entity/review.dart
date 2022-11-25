class Review {
  final String content;
  final int rating;
  late String userId;

  Review(
    this.userId,
    this.content,
    this.rating,
  );
}
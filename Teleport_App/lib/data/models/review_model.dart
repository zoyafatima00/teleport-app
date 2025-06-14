class ReviewModel {
  final int id;
  final String userName;
  final String userImage;
  final String comment;
  final double rating;
  final DateTime date;
  final String initials;

  ReviewModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.comment,
    required this.rating,
    required this.date,
    required this.initials,
  });
}

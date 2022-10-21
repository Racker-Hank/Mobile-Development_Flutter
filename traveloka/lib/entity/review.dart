import 'package:firebase_auth/firebase_auth.dart';

class Review {
  final String content;
  final int rating;
  late User user;

  Review(this.content, this.rating);
}

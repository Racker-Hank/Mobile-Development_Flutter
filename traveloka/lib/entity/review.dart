import 'package:firebase_auth/firebase_auth.dart';

class Review {
  final String content;
  final int rate;
  late User user;

  Review(this.content, this.rate);
}

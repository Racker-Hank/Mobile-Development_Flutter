import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/hotel.dart';

class HotelFirebase {
  static Stream<List<Hotel>> readHotels() {
    return FirebaseFirestore.instance.collection('hotels').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Hotel.fromJson(doc.data(), doc.id))
            .toList());
  }
}

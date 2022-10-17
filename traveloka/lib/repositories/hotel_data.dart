import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/hotel.dart';

class HotelFirebase {
  static Stream<List<Hotel>> readHotels() {
    return FirebaseFirestore.instance.collection('hotels').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Hotel.fromJson(doc.data(), doc.id))
            .toList());
  }

  // static Stream<List<Hotel>> searchHotelByName(String name) {
  //   return FirebaseFirestore.instance
  //       .collection('hotels')
  //       .orderBy("name")
  //       .startAt([name])
  //       .endAt(['$name\uf8ff'])
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //       .map((doc) => Hotel.fromJson(doc.data(), doc.id))
  //       .toList());
  // }
  //
  // static Stream<List<Hotel>> searchHotelByLocation(String location) {
  //   return FirebaseFirestore.instance
  //       .collection('hotels')
  //       .orderBy("location")
  //       .startAt([location])
  //       .endAt(['$location\uf8ff'])
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //       .map((doc) => Hotel.fromJson(doc.data(), doc.id))
  //       .toList());
  // }
}

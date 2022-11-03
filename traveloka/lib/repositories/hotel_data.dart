import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:traveloka/config/UI_configs.dart';
import 'package:traveloka/entity/hotel.dart';

// import '../entity/hotel.dart';

class HotelFirebase {
  static Stream<List<Hotel>> readHotels() {
    return FirebaseFirestore.instance.collection('hotels').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Hotel.fromJson(doc.data(), doc.id))
            .toList());
  }

  static Stream<List<Hotel>> readHotelsLimit(int limit) {
    return FirebaseFirestore.instance
        .collection('hotels')
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Hotel.fromJson(doc.data(), doc.id))
            .toList());
  }

  static Stream<List<Hotel>> searchHotelByName(String name) {
    // if (name.isEmpty) {
    //   // print('test');
    //   return readHotelsLimit(1);
    // }
    name = UIConfig.capitalize(name);
    return FirebaseFirestore.instance
        .collection('hotels')
        .orderBy('name')
        .startAt([name])
        .endAt(['$name\uf8ff'])
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Hotel.fromJson(doc.data(), doc.id))
            .toList());
  }

  static Stream<List<Hotel>> searchHotelByLocation(String location) {
    // if (location.isEmpty) {
    //   return readHotelsLimit(1);
    // }
    location = UIConfig.capitalize(location);
    print(location);
    return FirebaseFirestore.instance
        .collection('hotels')
        .orderBy('location')
        .startAt([location])
        .endAt(['$location\uf8ff'])
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Hotel.fromJson(doc.data(), doc.id))
            .toList());
  }
}
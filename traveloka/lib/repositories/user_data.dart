import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirebase {
  static String userId = FirebaseAuth.instance.currentUser!.uid;
  static Future<void> initUser(UserCredential userCred) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCred.user?.uid)
        .set(
      {
        'savedHotels': [],
        'app-theme': 1,
      },
    );
  }

  static Future<void> saveHotel(String hotelId, bool isSaved) async {
    if (!isSaved) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'savedHotels': FieldValue.arrayUnion([hotelId])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'savedHotels': FieldValue.arrayRemove([hotelId])
      });
    }
  }

  static Stream<List<String>> readSavedHotelsId() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => (snapshot.data()!['savedHotels'] as List)
            .map((e) => e as String)
            .toList());
  }

  static Future<bool> isSaved(String hotelId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) => ((snapshot.data()!['savedHotels'] as List)
            .map((e) => e as String)
            .toList()
            .contains(hotelId)));
  }
}

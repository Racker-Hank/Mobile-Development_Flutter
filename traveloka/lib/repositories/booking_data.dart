import 'package:cloud_firestore/cloud_firestore.dart';

import '../entity/booking.dart';

class BookingFirebase {
  static Future<Booking> createBooking(Booking booking) async {
    DocumentReference<Map<String, dynamic>> docRef =
        FirebaseFirestore.instance.collection('bookings').doc();
    await docRef.set({
      'bookingFromDate': booking.bookingFromDate,
      'bookingToDate': booking.bookingToDate,
      'bookingTimestamp': booking.bookingTimestamp,
      'userId': booking.userId,
      'hotelId': booking.hotelId,
      'price': booking.price,
      'status': booking.status,
    });
    return docRef.get().then((doc) => Booking.fromJson(doc.data()!, doc.id));
  }

  static void cancelBooking(String bookingId) {
    FirebaseFirestore.instance.collection('bookings').doc(bookingId).delete();
  }

  static void confirmBooking(String bookingId) {
    FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
      'status': true,
    });
  }

  // static void updateBooking(BookingHotel bookingHotel, String bookingId) {
  //   FirebaseFirestore.instance.collection('bookings')
  //     .doc(bookingId)
  //     .set(bookingHotel)
  //     .then((e) -> {return "success"})
  //   return "failed"
  // }

  // static Stream<List<BookingHotel>> getBookingForUser(String userId) {
  //   return FirebaseFirestore.instance.collection('bookings')
  //     .where("userId", isEqualTo: userId)
  //     .snapshot()
  //     .map((snapshot) => snapshot.docs
  //       .map((doc) => BookingHotel.fromJson(doc.data(), doc.id))
  //       .toList());
  // }
}

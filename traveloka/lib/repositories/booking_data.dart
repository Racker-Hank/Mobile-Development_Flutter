import 'package:cloud_firestore/cloud_firestore.dart';
import '../entity/booking.dart';

class BookingFirebase {
  static void createBooking(BookingHotel bookingHotel) {
    FirebaseFirestore.instance.collection('bookings')
      .add(bookingHotel)
      .then((e) => {return "success";})
    return "failed"
  }

  static void cancleBooking(String bookingId) {
    FirebaseFirestore.instance.collection('bookings')
      .doc(bookingId)
      .delete()
      .then((e) -> {return "success"})
    return "failed"
  }

  static void updateBooking(BookingHotel bookingHotel, String bookingId) {
    FirebaseFirestore.instance.collection('bookings')
      .doc(bookingId)
      .set(bookingHotel)
      .then((e) -> {return "success"})
    return "failed"
  }

  static Stream<List<BookingHotel>> getBookingForUser(String userId) {
    return FirebaseFirestore.instance.collection('bookings')
      .where("userId", isEqualTo: userId)
      .snapshot()
      .map((snapshot) => snapshot.docs
        .map((doc) => BookingHotel.fromJson(doc.data(), doc.id))
        .toList());
  }
}
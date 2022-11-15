import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
      'guests': booking.guests,
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

  static Stream<List<Booking>> readBookingsByUserId(String userId) {
    return FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('bookingTimestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Booking.fromJson(doc.data(), doc.id))
        .toList()
    );
  }

  static void updateBookingDate(String bookingId, DateTimeRange dateRange, int price) {
    FirebaseFirestore.instance.collection('bookings')
        .doc(bookingId)
        .update({
          'bookingFromDate': dateRange.start,
          'bookingToDate': dateRange.end,
          'price': price
        });
  }

  static void updateBookingGuests(String bookingId, int guests) {
    FirebaseFirestore.instance.collection('bookings')
        .doc(bookingId)
        .update({
          'guests': guests
        });
  }

  // static Stream<List<Booking>> readRecentBookings(String userId) {
  //
  // }

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

import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  late String id;
  late DateTime bookingFromDate;
  late DateTime bookingToDate;
  late DateTime bookingTimestamp;
  late String userId;
  late String hotelId;
  late int price;
  late bool status;

  Booking(
    this.id,
    this.bookingFromDate,
    this.bookingToDate,
    this.bookingTimestamp,
    this.userId,
    this.hotelId,
    this.price,
    this.status,
  );

  Booking.empty();

  static Booking fromJson(Map<String, dynamic> json, String id) {
    Booking booking = Booking.empty();

    booking.id = id;
    booking.bookingFromDate = DateTime.parse(
        (json['bookingFromDate'] as Timestamp).toDate().toString());
    booking.bookingToDate = DateTime.parse(
        (json['bookingToDate'] as Timestamp).toDate().toString());
    booking.bookingTimestamp = DateTime.parse(
        (json['bookingTimestamp'] as Timestamp).toDate().toString());
    booking.userId = json['userId'];
    booking.hotelId = json['hotelId'];
    booking.price = json['price'];
    booking.status = json['status'];

    return booking;
  }
}

class Booking {
  late String id;
  late DateTime bookingFromDate;
  late DateTime bookingToDate;
  late DateTime bookingTimestamp;
  late String userId;
  late String hotelId;
  late int price;
  late bool status;

  static Booking fromJson(Map<String, dynamic> json, String id) {
    Booking booking = Booking();

    booking.id = id;
    booking.bookingFromDate = DateTime.parse(json['bookingFromDate']);
    booking.bookingToDate = DateTime.parse(json['bookingToDate']);
    booking.bookingTimestamp = DateTime.parse(json['bookingTimestamp']);
    booking.userId = json['userId'];
    booking.hotelId = json['hotelId'];
    booking.price = json['price'];
    booking.status = json['status'];

    return booking;
  }
}

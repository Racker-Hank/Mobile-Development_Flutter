class BookingHotel {
  late String id;
  late DateTime bookingFromDate;
  late DateTime bookingToDate;
  late DateTime bookingTimestamp;
  late String userId;
  late String hotelId;
  late int price;

  static BookingHotel fromJson(Map<String, dynamic> json, String id) {
    BookingHotel ans = BookingHotel();
    
    ans.id = id;
    ans.bookingFromDate = DateTime.parse(json["bookingFromDate"]);
    ans.bookingToDate = DateTime.parse(json["bookingToDate"]);
    ans.bookingTimestamp = DateTime.parse(json["bookingTimestamp"]);
    ans.userId = json["userId"];
    ans.hotelId = json["hotelId"];
    ans.price = json["price"];

    return ans;
  }
}

class Hotel {
  final int id;
  final String? imageURL;
  final String hotelName;
  final String location;
  final double? ratings;
  final int price;
  final String description;

  const Hotel(this.id, this.imageURL, this.hotelName, this.location,
      this.ratings, this.price, this.description);

  static Hotel hotel1 = const Hotel(
      1,
      'https://images.unsplash.com/photo-1561501900-3701fa6a0864?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Resort',
      'Miami',
      4.5,
      500,
      'noice');
  static Hotel hotel2 = const Hotel(
      2,
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Resort 2',
      'Miami 2',
      4.1,
      400,
      'noice 2');
  static Hotel hotel3 = const Hotel(
      3,
      'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
      'Florida Getaway',
      'Florida villa',
      3.8,
      200,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');
  static Hotel hotel4 = const Hotel(
      4,
      'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Deluxe',
      'Miami 5 star luxury hotel',
      4.8,
      800,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');

  static final List hotels = [hotel4, hotel3, hotel1, hotel2];
}

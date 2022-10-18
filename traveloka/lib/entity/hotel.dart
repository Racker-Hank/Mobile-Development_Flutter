import 'review.dart';

class Hotel {
  /* final int id;
  final String imageURL;
  final String name;
  final String location;
  final double? ratings;
  final int price;
  final String description;
  final List<String> reviews;
  final String mapURL;

  const Hotel(this.id, this.imageURL, this.name, this.location, this.ratings,
      this.price, this.description, this.reviews, this.mapURL);

  static Hotel hotel1 = const Hotel(
    1,
    'https://images.unsplash.com/photo-1561501900-3701fa6a0864?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'Miami Resort',
    'Miami',
    4.5,
    500,
    'noice',
    [
      'good',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor'
    ],
    'https://www.google.com/maps/d/thumbnail?mid=1c86RLT61hsCavEyRj84zrSDmsEABJY3V',
  );
  static Hotel hotel2 = const Hotel(
    2,
    'https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'Miami Resort 2',
    'Miami 2',
    4.1,
    400,
    'noice 2',
    ['good', 'amazing'],
    'https://www.google.com/maps/d/thumbnail?mid=1VozMiI5CTxLcOmBw5JcchOUO52g&hl=en',
  );
  static Hotel hotel3 = const Hotel(
    3,
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
    'Florida Getaway',
    'Florida villa',
    3.8,
    200,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ['good', 'amazing'],
    'https://www.google.com/maps/d/thumbnail?mid=1OP6io86VfILShopkxRFP5Ne_74k&hl=en',
  );
  static Hotel hotel4 = const Hotel(
    4,
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'Miami Deluxe',
    'Miami 5 star luxury hotel',
    4.8,
    800,
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    ['good', 'amazing'],
    'https://www.google.com/maps/d/thumbnail?mid=1xuVn-8pB6LncSXkLnGD5veeGboA&hl=en_US',
  );

  static final List hotels = [hotel4, hotel3, hotel1, hotel2]; */
  late String id;
  late List<String> imageURLs;
  // late String heroImage;
  late String name;
  late String location;
  late double? ratings;
  late List<Review> reviews;
  late int price;
  late String description;
  late Map<String, String> contacts;
  late Map<String, bool> facilities;
  late String mapURL;

  Hotel(
    this.id,
    this.imageURLs,
    this.name,
    this.location,
    this.ratings,
    this.reviews,
    this.price,
    this.description,
    this.facilities,
    this.mapURL,
  );

  @override
  bool operator ==(other) {
    return other is Hotel && other.runtimeType == runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  static Hotel fromJson(Map<String, dynamic> json, String id) {
    List<String> imageURLs =
        (json['imageURLs'] as List).map((e) => e as String).toList();

    List<Review> reviews = (json['reviews'] as List)
        .map((e) => Review(e['content'], e['ratings']))
        .toList();

    Map<String, bool> facilities = {};
    for (var e in (json['facilities'] as Map).entries) {
      facilities[e.key] = e.value as bool;
    }

    return Hotel(
      id,
      imageURLs,
      json['name'],
      json['location'],
      json['ratings'],
      reviews,
      json['price'],
      json['description'],
      facilities,
      json['mapURL'],
    );
  }
}

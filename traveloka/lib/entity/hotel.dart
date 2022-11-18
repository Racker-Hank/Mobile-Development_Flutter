import 'review.dart';

class Hotel {
  late String id;
  late List<String> imageURLs;
  late String name;
  late String location;
  late int maxRoomCapacity;
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
    this.maxRoomCapacity,
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
        .map((e) => Review(e['userId'], e['content'], e['rating']))
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
      json['maxRoomCapacity'],
      reviews,
      json['price'],
      json['description'],
      facilities,
      json['mapURL'],
    );
  }
}

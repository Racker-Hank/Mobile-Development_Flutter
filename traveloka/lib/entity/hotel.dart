class Hotel {
  late String id;
  late List<String> imageURLs;
  late String name;
  late String location;
  late double? ratings;
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
    this.price,
    this.description,
    this.mapURL,
  );

  static Hotel fromJson(Map<String, dynamic> json, String id) {
    List<String> imageURLs =
        (json['imageURLs'] as List).map((e) => e as String).toList();

    return Hotel(
      id,
      imageURLs,
      json['name'],
      json['location'],
      json['ratings'],
      json['price'],
      json['description'],
      json['mapURL'],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:traveloka/view/hotel_view.dart';
import '../config/ui_configs.dart';

import '../entity/hotel.dart';
import '../view/booking_view.dart';
import '../view/search_view.dart';
// import 'package:hello_world/entity/Hotel.dart';

class HotelCard extends StatelessWidget {
  const HotelCard({
    super.key,
    this.width,
    this.height,
    this.hMargin,
    this.vMargin,
    // this.hotel,
    // required this.hotelID,
    // this.imageURL =
    //     'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
    // this.hotelName = 'Florida Getaway',
    // this.location = 'Florida villa',
    // this.ratings = 3.8,
    // this.price = 200,
    // this.description =
    //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
    required this.hotel,
    required this.showFacilities,
  });

  final double? width;

  final double? height;

  final double? hMargin;

  final double? vMargin;

  final double columnSpacing = 8;

  // final Hotel defaultHotel = Hotel(
  //     'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
  //     'Florida Getaway',
  //     'Florida villa',
  //     3.8,
  //     200,
  //     'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');

  final Hotel hotel;

  // final int hotelID;

  // final String imageURL;

  // final String hotelName;

  // final String location;

  // final double? ratings;

  // final int price;

  // final String description;

  final bool showFacilities;

  static var facilitiesUI = {
    'pool': Icon(
      Icons.pool_rounded,
      color: UIConfig.darkGrey,
      // size: 24,
    ),
    'breakfast': Icon(
      Icons.restaurant_rounded,
      color: UIConfig.darkGrey,
      // size: 24,
    ),
    'wifi': Icon(
      Icons.wifi_rounded,
      color: UIConfig.darkGrey,
      // size: 24,
    ),
    'bar': Icon(
      Icons.nightlife_rounded,
      color: UIConfig.darkGrey,
      // size: 24,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   print('Tapped');
      // },
      // onTap: () => {
      //   // debugPrint('$hotelID'),
      //   Navigator.of(context).push(
      //     PageRouteBuilder(
      //       pageBuilder: (context, animation, secondaryAnimation) =>
      //           const MySearchPage(),
      //       transitionsBuilder:
      //           (context, animation, secondaryAnimation, child) {
      //         return child;
      //       },
      //     ),
      //   ),
      // },
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHotelPage(hotel: hotel),
        ),
      ),
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInQuart,
        constraints: const BoxConstraints(maxWidth: 350, minWidth: 284),
        // constraints: const BoxConstraints(minWidth: 284),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: hMargin ?? 16),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: UIConfig.borderRadius,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(50, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
          color: UIConfig.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroImage(hotelID: hotel.id, imageURL: hotel.imageURLs[0]),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadLine(hotelName: hotel.name, location: hotel.location),
                  SizedBox(height: columnSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: Ratings(
                          ratings: hotel.reviews.isNotEmpty
                              ? hotel.reviews
                                      .map((e) => e.ratings)
                                      .reduce((a, b) => a + b) /
                                  hotel.reviews.length
                              : 0,
                        ),
                      ),
                      Price(price: hotel.price),
                    ],
                  ),
                  SizedBox(height: columnSpacing),
                  Description(description: hotel.description),
                  const SizedBox(height: 16),
                  Facilities(
                    showFacilities: showFacilities,
                    facilitiesUI: facilitiesUI,
                    facilities: hotel.facilities,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.hotelID,
    required this.imageURL,
  }) : super(key: key);

  final String imageURL;
  final String hotelID;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Hero(
            tag: 'hotel_${hotelID}_image',
            child: Container(
              height: 150,
              foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeadLine extends StatelessWidget {
  const HeadLine({
    Key? key,
    required this.hotelName,
    required this.location,
  }) : super(key: key);

  final String hotelName;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hotelName,
          style: UIConfig.titleLargeTextStyle,
        ),
        const SizedBox(height: 2),
        Text(
          '📍 $location',
          style: UIConfig.bodyMediumTextStyle,
        ),
      ],
    );
  }
}

class Ratings extends StatelessWidget {
  const Ratings({
    Key? key,
    required this.ratings,
  }) : super(key: key);

  final double ratings;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        ratings - ratings.toInt() != 0
            ? ratings.toStringAsFixed(1)
            : '$ratings',
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.bold,
          letterSpacing: .25,
          color: Colors.black,
        ),
      ),
      const SizedBox(width: 2),
      Icon(
        Icons.star_rounded,
        color: UIConfig.accentColor,
        size: 20,
      ),
    ]);
  }
}

class Price extends StatelessWidget {
  const Price({
    Key? key,
    required this.price,
  }) : super(key: key);

  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      decoration: BoxDecoration(
        color: UIConfig.accentColor,
        borderRadius: UIConfig.borderRadius,
      ),
      child: Text(
        '\$$price',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          height: 1.4,
          letterSpacing: .25,
          color: UIConfig.white,
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.description,
    this.maxHeight = 60,
  }) : super(key: key);

  final String description;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: Text(description),
    );
  }
}

class Facilities extends StatelessWidget {
  const Facilities({
    Key? key,
    required this.showFacilities,
    required this.facilitiesUI,
    required this.facilities,
  }) : super(key: key);

  final bool showFacilities;
  final Map<String, Icon> facilitiesUI;
  final Map<String, bool> facilities;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showFacilities,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: facilitiesUI.entries
              .map((e) => Visibility(
                    visible: facilities[e.key] ?? false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          e.value,
                          const SizedBox(height: 4),
                          Text(
                            '${e.key[0].toUpperCase()}${e.key.substring(1)}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: UIConfig.darkGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
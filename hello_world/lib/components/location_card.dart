import 'package:flutter/material.dart';
import 'package:hello_world/config/UI_configs.dart';

import '../view/search_view.dart';
// import 'package:hello_world/entity/Hotel.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    this.width,
    this.height,
    this.hMargin,
    this.vMargin,
    // this.hotel,
    required this.hotelID,
    this.imageURL =
        'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
    this.hotelName = 'Florida Getaway',
    this.location = 'Florida villa',
    this.ratings = 3.8,
    this.price = 200,
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
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

  // final Hotel? hotel;

  final int hotelID;

  final String imageURL;

  final String hotelName;

  final String location;

  final double? ratings;

  final int price;

  final String description;

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
          builder: (context) => const MySearchPage(),
        ),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 330, minWidth: 300),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: hMargin ?? 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UIConfig.borderRadius),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color.fromARGB(15, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
          color: UIConfig.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroImage(hotelID: hotelID, imageURL: imageURL),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadLine(hotelName: hotelName, location: location),
                  SizedBox(height: columnSpacing),
                  Row(
                    children: [
                      Ratings(ratings: ratings),
                      Price(price: price),
                    ],
                  ),
                  SizedBox(height: columnSpacing),
                  Description(description: description),
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
  final int hotelID;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Hero(
            tag: 'hotel${hotelID}_image',
            child: Container(
              height: 150,
              foregroundDecoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover,
              )),
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

  final double? ratings;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(children: [
        Text(
          '$ratings',
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
      ]),
    );
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
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
      decoration: BoxDecoration(
        color: UIConfig.accentColor,
        borderRadius: BorderRadius.circular(UIConfig.borderRadius),
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
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 60),
      child: Text(description),
    );
  }
}

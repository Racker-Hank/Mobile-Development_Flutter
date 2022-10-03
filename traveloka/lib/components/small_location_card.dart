import 'package:flutter/material.dart';
import 'package:traveloka/components/location_card.dart';
import 'package:traveloka/config/UI_configs.dart';
import 'package:traveloka/view/hotel_details_view.dart';

class SmallLocationCard extends StatelessWidget {
  const SmallLocationCard({
    super.key,
    this.width,
    this.height,
    this.hMargin,
    this.vMargin,
    required this.hotelID,
    required this.imageURL,
    required this.hotelName,
    required this.location,
  });

  final double? width;

  final double? height;

  final double? hMargin;

  final double? vMargin;

  final double columnSpacing = 8;

  final int hotelID;

  final String imageURL;

  final String hotelName;

  final String location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHotelDetailsPage()
        )
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 330, minWidth: 300),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: hMargin ?? 16),
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: UIConfig.borderRadius,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0
            ),
            BoxShadow(
              color: Color.fromARGB(15, 0, 0, 0),
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1
            )
          ],
          color: UIConfig.white
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroImage(hotelID: hotelID, imageURL: imageURL)
          ],
        ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.imageURL,
    required this.hotelID
  }) : super(key: key);

  final String imageURL;
  final int hotelID;

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}


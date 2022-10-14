import 'package:flutter/material.dart';
import '../entity/hotel.dart';
import 'package:traveloka/view/hotel_view.dart';
import '../config/ui_configs.dart';
import 'hotel_card.dart';

class HotelTile extends StatelessWidget {
  const HotelTile(
      {super.key,
      this.width,
      this.height,
      this.hMargin,
      this.vMargin,
      required this.hotel});

  final double? width;

  final double? height;

  final double? hMargin;

  final double? vMargin;

  final double columnSpacing = 8;

  final Hotel hotel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHotelPage(hotel: hotel),
        ),
      ),
      child: Container(
        // width: width,
        height: 80,
        // duration: const Duration(milliseconds: 500),
        // curve: Curves.easeInQuart,
        constraints: const BoxConstraints(maxWidth: 350, minWidth: 284),
        // constraints: const BoxConstraints(minWidth: 284),
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: hMargin ?? 16),
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
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(hotel.name),
          subtitle: Text('📍 ${hotel.location}'),
          // leading: HeroImage(
          //   hotelID: hotel.id,
          //   imageURL: hotel.imageURLs[0],
          // ),
          leading: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 80, maxWidth: 80),
            child: Image.network(hotel.imageURLs[0]),
          ),

          // leading: CircleAvatar(
          //   radius: 40,
          //   backgroundImage: NetworkImage(
          //     hotel.imageURLs[0],
          //   ),
          // ),
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
              decoration: BoxDecoration(
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

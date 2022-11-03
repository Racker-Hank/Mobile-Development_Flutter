import 'package:flutter/material.dart';
import 'package:traveloka/entity/hotel.dart';
// import '../entity/hotel.dart';
import 'package:traveloka/view/hotel_view.dart';
import '../config/ui_configs.dart';

class HotelTile extends StatelessWidget {
  const HotelTile({
    super.key,
    this.hMargin,
    this.vMargin,
    required this.hotel,
  });

  final double? hMargin;

  final double? vMargin;

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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        height: 80,
        // curve: Curves.easeInQuart,
        // margin: EdgeInsets.symmetric(vertical: 0, horizontal: hMargin ?? 16),
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
        child: Row(
          children: [
            Hero(
              tag: 'hotel_${hotel.id}_image',
              child: Image.network(
                hotel.imageURLs[0],
                height: 80,
                width: (MediaQuery.of(context).size.width - 32) / 4,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      // letterSpacing: .1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '📍 ${hotel.location}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.keyboard_arrow_right_rounded,
              ),
            ),
          ],
        ),

        // child: ListTile(
        //   contentPadding: EdgeInsets.zero,
        //   title: Text(hotel.name),
        //   subtitle: Text('📍 ${hotel.location}'),
        //   leading: ConstrainedBox(
        //     constraints: const BoxConstraints(minHeight: 80, maxWidth: 80),
        //     child: Image.network(hotel.imageURLs[0]),
        //   ),
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

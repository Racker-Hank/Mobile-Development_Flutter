import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traveloka/entity/booking.dart';
import 'package:traveloka/entity/hotel.dart';
import 'package:traveloka/view/booking/booking_detail_view.dart';
import '../config/ui_configs.dart';
import '../view/hotel/hotel_view.dart';

class HotelTile extends StatelessWidget {
  const HotelTile({
    super.key,
    this.hMargin,
    this.vMargin,
    this.showBooking = false,
    required this.hotel,
    // this.bookingId,
    this.booking,
  });

  final bool showBooking;

  final double? hMargin;

  final double? vMargin;

  final Hotel hotel;

  final Booking? booking;

  // final String? bookingId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (!showBooking) {
              return MyHotelPage(hotel: hotel);
            } else {
              return BookingDetailPage(hotel: hotel, booking: booking!);
            }
          },
        ),
      ),
      // onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        height: 80,
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
              tag: showBooking
                  ? 'booking_${booking!.id}_image'
                  : 'hotel_${hotel.id}_image',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        child: Text(
                          hotel.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      // const SizedBox(width: 4),
                      if (showBooking && booking!.status)
                        Tooltip(
                          message: 'Confirmed',
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 4,
                            ),
                            child: Icon(
                              Icons.check_circle_rounded,
                              color: UIConfig.primaryColor,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    showBooking
                        ? '📅 ${DateFormat('MMM d, yyyy').format(booking!.bookingTimestamp)}'
                        : '📍 ${hotel.location}',
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

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:traveloka/entity/booking.dart';
import 'package:traveloka/repositories/hotel_data.dart';
import '../components/hotel_card.dart';
import '../entity/hotel.dart';
import '../config/UI_configs.dart';

class PastBookingDetailPage extends StatefulWidget {
  const PastBookingDetailPage({
    super.key,
    required this.bookingHotel,
    required Hotel hotel,
  });

  final BookingHotel bookingHotel;

  @override
  State<PastBookingDetailPage> createState() => _PastBookingDetailPageState();
}

class _PastBookingDetailPageState extends State<PastBookingDetailPage> {
  bool isSaved = false;
  String heroImageURL = '';
  double imageSpacing = 4;
  late Hotel hotel;

  @override
  Widget build(BuildContext context) {
    var smallImageWidth =
        (MediaQuery.of(context).size.width - imageSpacing * 4) / 5;
    hotel = HotelFirebase.getHotelById(widget.bookingHotel.hotelId) as Hotel;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(
        children: [
          imagesContainer(context, smallImageWidth),
          headerButtons(context)
        ],
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 50),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      HeadLine(hotelName: hotel.name, location: hotel.location),
                ),
                Ratings(
                  avgRatings: hotel.reviews.isNotEmpty
                      ? hotel.reviews
                              .map((e) => e.rating)
                              .reduce((a, b) => a + b) /
                          hotel.reviews.length
                      : 0,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
                color: const Color.fromARGB(70, 0, 0, 0),
                child: Column(
                  children: [
                    Text('Id: ${widget.bookingHotel.id}'),
                    Text('Time: ${widget.bookingHotel.bookingFromDate}'),
                  ],
                )),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ]);
  }

  Container headerButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_rounded,
              color: UIConfig.white,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  isSaved = !isSaved;
                }),
                child: AnimatedCrossFade(
                  firstChild: Icon(
                    Icons.bookmark_border_rounded,
                    color: UIConfig.white,
                  ),
                  secondChild: Icon(
                    Icons.bookmark_rounded,
                    color: UIConfig.white,
                  ),
                  crossFadeState: isSaved
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 200),
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.share_rounded,
                color: UIConfig.white,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container imagesContainer(BuildContext context, double smallImageWidth) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(70, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            offset: Offset(0, 6),
            blurRadius: 10,
            spreadRadius: 4,
          ),
        ],
        color: UIConfig.screenBackgroundColor,
      ),
      child: Column(
        children: [
          Hero(
            tag: 'hotel${hotel.id}_image',
            child: Container(
              height: MediaQuery.of(context).size.width * 2 / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(heroImageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: imageSpacing),
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                GestureDetector(
                  onTap: () => setState(() {
                    heroImageURL = hotel.imageURLs[i];
                  }),
                  child: Container(
                    width: smallImageWidth,
                    height: smallImageWidth,
                    margin: EdgeInsets.only(right: imageSpacing),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(hotel.imageURLs[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  if (hotel.imageURLs.length == 5) {
                    setState(() {
                      heroImageURL = hotel.imageURLs[4];
                    });
                  }
                },
                child: Container(
                  width: smallImageWidth,
                  height: smallImageWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(hotel.imageURLs[4]),
                      fit: BoxFit.cover,
                      colorFilter: hotel.imageURLs.length - 5 > 0
                          ? ColorFilter.mode(
                              UIConfig.black.withOpacity(.4),
                              BlendMode.softLight,
                            )
                          : null,
                    ),
                  ),
                  child: hotel.imageURLs.length - 5 > 0
                      ? Center(
                          child: Text(
                            '+${hotel.imageURLs.length - 4}',
                            style: TextStyle(
                              fontSize: 16,
                              color: UIConfig.white,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
                      : null,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traveloka/entity/booking.dart';
import 'package:traveloka/repositories/hotel_data.dart';
import '../components/button.dart';
import '../components/hotel_card.dart';
import '../entity/hotel.dart';
import '../config/UI_configs.dart';

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({
    super.key,
    required this.hotel,
  });

  final Hotel hotel;

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  bool isSaved = false;
  String heroImageURL = '';
  double imageSpacing = 4;
  //late Hotel hotel;

  late final TextEditingController _daterange;
  late final TextEditingController _guests;

  @override
  void initState() {
    _daterange = TextEditingController();
    _guests = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _daterange.dispose();
    _guests.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var smallImageWidth = (MediaQuery.of(context).size.width - imageSpacing * 4) / 5;
    //hotel = HotelFirebase.getHotelById(widget.hotel.id) as Hotel;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
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
                      tag: 'hotel${widget.hotel.id}_image',
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
                  ],
                ),
              ),
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
                      HeadLine(
                          hotelName: widget.hotel.name,
                          location: widget.hotel.location
                      ),
                    ),
                    Ratings(
                      avgRatings: widget.hotel.reviews.isNotEmpty
                          ? widget.hotel.reviews
                          .map((e) => e.rating)
                          .reduce((a, b) => a + b) /
                          widget.hotel.reviews.length
                          : 0,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFDADDE3),
                      borderRadius: UIConfig.borderRadius,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Row(
                            children: [
                              Text(
                                'Booking ID: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    color: UIConfig.black
                                ),
                              ),
                              const SizedBox(width: 32),
                              Text(
                                widget.hotel.id,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: UIConfig.black
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                'Booked on: ',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    color: UIConfig.black
                                ),
                              ),
                              const SizedBox(width: 32),
                              Text(
                                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: UIConfig.black
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                ),
                const SizedBox(height: 16),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Booking detail',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: UIConfig.black
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16, right: 16, bottom: 16),
                            child: Icon(Icons.calendar_month_outlined),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Duration',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    color: UIConfig.black
                                  ),
                                ),
                                Text(
                                  'data',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: UIConfig.black
                                  ),
                                )
                              ],
                            )
                          ),
                          GestureDetector(
                            child: const Icon(
                              Icons.border_color_rounded,
                              color: Color(0xFF1CA0E3),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16, right: 16, bottom: 16),
                            child: Icon(Icons.people),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Guests',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.normal,
                                    color: UIConfig.black
                                  ),
                                ),
                                Text(
                                  'data',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: UIConfig.black
                                  ),
                                )
                              ],
                            )
                          ),
                          GestureDetector(
                            child: const Icon(
                              Icons.border_color_rounded,
                              color: Color(0xFF1CA0E3),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFDC362E),
                            borderRadius: UIConfig.borderRadius,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(70, 0, 0, 0),
                                  offset: Offset(0, 2),
                                  blurRadius: 3),
                              BoxShadow(
                                  color: Color.fromARGB(30, 0, 0, 0),
                                  offset: Offset(0, 6),
                                  blurRadius: 10,
                                  spreadRadius: 4)
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cancel',
                                style: UIConfig.buttonTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Button(
                        label: 'Confirm',
                        function: () {},
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ]
      ),
    );
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
}
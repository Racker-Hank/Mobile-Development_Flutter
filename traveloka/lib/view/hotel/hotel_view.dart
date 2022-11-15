import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:traveloka/components/button.dart';
import 'package:traveloka/entity/booking.dart';
import 'package:traveloka/repositories/user_data.dart';
import 'package:traveloka/view/hotel/hotel_view_header_buttons.dart';
import 'dart:math' as math;
import '../../components/hotel_card.dart';
import '../../config/primitive_wrapper.dart';
import '../../config/ui_configs.dart';
import '../../entity/hotel.dart';
import '../../repositories/booking_data.dart';
import '../booking/booking_detail_view.dart';

class MyHotelPage extends StatefulWidget {
  const MyHotelPage({
    super.key,
    required this.hotel,
    this.defaultDateRange,
    this.defaultGuests,
  });

  final Hotel hotel;
  final DateTimeRange? defaultDateRange;
  final int? defaultGuests;

  @override
  State<MyHotelPage> createState() => _MyHotelPageState();
}

class _MyHotelPageState extends State<MyHotelPage> {
  late bool isSaved = false;
  String heroImageURL = '';
  double imageSpacing = 4;
  late DateTimeRange dateRange;
  late int guests;

  final reviewsKey = GlobalKey();
  final descriptionKey = GlobalKey();
  @override
  void initState() {
    heroImageURL = widget.hotel.imageURLs[0];
    dateRange = widget.defaultDateRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 7,
          ),
        );
    guests = widget.defaultGuests ?? 2;
    UserFirebase.isSaved(widget.hotel.id).then((value) => setState(() {
          isSaved = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var smallImageWidth =
        (MediaQuery.of(context).size.width - imageSpacing * 4) / 5;

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  imagesContainer(context, smallImageWidth),
                  // headerButtons(context)
                  HotelViewHeaderButtons(
                    parentWidgetContext: context,
                    isSaved: PrimitiveWrapper(isSaved),
                    hotel: widget.hotel,
                  ),
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
                          child: HeadLine(
                            hotelName: widget.hotel.name,
                            location: widget.hotel.location,
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
                    AnchorButtons(
                      descriptionKey: descriptionKey,
                      widget: widget,
                      reviewsKey: reviewsKey,
                    ),
                    const SizedBox(height: 16),
                    ReadMoreText(
                      key: descriptionKey,
                      widget.hotel.description,
                      style: UIConfig.bodyMediumTextStyle,
                      trimCollapsedText: 'Expand',
                      trimExpandedText: 'Collapse',
                      moreStyle: UIConfig.indicationTextStyle,
                      lessStyle: UIConfig.indicationTextStyle,
                    ),
                    const SizedBox(height: 16),
                    Facilities(
                      showFacilities: true,
                      facilitiesUI: HotelCard.facilitiesUI,
                      facilities: widget.hotel.facilities,
                    ),
                    const SizedBox(height: 16),
                    Directions(widget: widget),
                    const SizedBox(height: 16),
                    // Container(
                    //   height: 1,
                    //   color: UIConfig.primaryColor,
                    // ),
                    Reviews(
                      reviewsKey: reviewsKey,
                      widget: widget,
                    ),
                  ],
                ),
              ),
            ],
          ),
          BookingCTA(
              widget: widget,
              function: () {
                BookingFirebase.createBooking(
                  Booking(
                    '',
                    dateRange.start,
                    dateRange.end,
                    DateTime.now(),
                    FirebaseAuth.instance.currentUser!.uid,
                    widget.hotel.id,
                    guests,
                    widget.hotel.price * dateRange.duration.inDays,
                    false,
                  ),
                ).then((booking) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailPage(
                        hotel: widget.hotel,
                        booking: booking,
                        defaultDateRange: dateRange,
                      ),
                    )).then((value) => setState(() {})));
              }),
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
          SizedBox(height: imageSpacing),
          Row(
            children: [
              for (int i = 0; i < 4; i++)
                GestureDetector(
                  onTap: () => setState(() {
                    heroImageURL = widget.hotel.imageURLs[i];
                  }),
                  child: Container(
                    width: smallImageWidth,
                    height: smallImageWidth,
                    margin: EdgeInsets.only(right: imageSpacing),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.hotel.imageURLs[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              GestureDetector(
                onTap: () {
                  if (widget.hotel.imageURLs.length == 5) {
                    setState(() {
                      heroImageURL = widget.hotel.imageURLs[4];
                    });
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: smallImageWidth,
                      height: smallImageWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.hotel.imageURLs[4]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (widget.hotel.imageURLs.length - 5 > 0)
                      Container(
                        width: smallImageWidth,
                        height: smallImageWidth,
                        color: const Color(0XFF000000).withOpacity(.5),
                        child: Center(
                          child: Text(
                            '+${widget.hotel.imageURLs.length - 4}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0XFFFFFFFF),
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AnchorButtons extends StatelessWidget {
  const AnchorButtons({
    Key? key,
    required this.descriptionKey,
    required this.widget,
    required this.reviewsKey,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> descriptionKey;
  final MyHotelPage widget;
  final GlobalKey<State<StatefulWidget>> reviewsKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            final context = descriptionKey.currentContext!;
            await Scrollable.ensureVisible(
              context,
              alignment: 1,
              duration: const Duration(milliseconds: 500),
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            decoration: BoxDecoration(
              color: UIConfig.accentColor,
              borderRadius: UIConfig.borderRadius,
              border: Border.all(
                color: Colors.transparent,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                  blurStyle: BlurStyle.solid,
                  color: UIConfig.black.withOpacity(.2),
                ),
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  color: UIConfig.black.withOpacity(.15),
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Text(
              'Details',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                height: 1.4,
                letterSpacing: .25,
                color: UIConfig.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        if (widget.hotel.reviews.isNotEmpty)
          GestureDetector(
            onTap: () async {
              final context = reviewsKey.currentContext!;
              await Scrollable.ensureVisible(
                context,
                alignment: 0,
                duration: const Duration(milliseconds: 500),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              decoration: BoxDecoration(
                color: UIConfig.white,
                borderRadius: UIConfig.borderRadius,
                border: Border.all(
                  color: UIConfig.accentColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    blurStyle: BlurStyle.solid,
                    color: UIConfig.black.withOpacity(.2),
                  ),
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    color: UIConfig.black.withOpacity(.15),
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Text(
                'Reviews',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  height: 1.4,
                  letterSpacing: .25,
                  color: UIConfig.accentColor,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class Directions extends StatelessWidget {
  const Directions({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MyHotelPage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Map',
          style: UIConfig.indicationTextStyle,
        ),
        const SizedBox(height: 8),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(
              color: UIConfig.accentColor,
              width: 1,
            ),
            borderRadius: UIConfig.borderRadius,
            image: DecorationImage(
              image: NetworkImage(widget.hotel.mapURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class BookingCTA extends StatelessWidget {
  const BookingCTA({
    Key? key,
    required this.widget,
    required this.function,
  }) : super(key: key);

  final MyHotelPage widget;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              UIConfig.primaryColor,
              UIConfig.accentColor,
            ],
            transform: const GradientRotation(math.pi * 0.14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$${widget.hotel.price}',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: UIConfig.white,
                    ),
                  ),
                  TextSpan(
                    text: '/Night',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: UIConfig.white,
                    ),
                  ),
                ],
              ),
            ),
            Button(
              function: function,
              label: 'Book Now',
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: UIConfig.white,
              ),
              showIcon: true,
            )
          ],
        ),
      ),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({
    Key? key,
    required this.reviewsKey,
    required this.widget,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> reviewsKey;
  final MyHotelPage widget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.hotel.reviews.isNotEmpty,
      replacement: Center(
        child: Text(
          '🤷‍♂️ No review yet 🤷‍♀️',
          style: TextStyle(
            color: UIConfig.accentColor,
            fontSize: 20,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: Column(
        key: reviewsKey,
        children: widget.hotel.reviews
            .map((e) => ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  leading: const CircleAvatar(radius: 20),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Text('UserName'),
                        ),
                        Row(
                          children: [
                            for (var i = 0; i < e.rating; i++)
                              Icon(
                                Icons.star_rounded,
                                color: UIConfig.accentColor,
                                size: 20,
                              ),
                            for (var i = e.rating; i < 5; i++)
                              Icon(
                                Icons.star_rounded,
                                color: UIConfig.darkGrey,
                                size: 20,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  subtitle: SelectableText(
                    e.content,
                    style: UIConfig.bodyMediumTextStyle,
                  ),
                ))
            .toList(),
      ),
    );
    // return const Text('Reviews');
  }
}

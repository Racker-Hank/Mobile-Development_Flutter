// import 'dart:html';
// import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:traveloka/components/button.dart';
import 'package:traveloka/repositories/user_data.dart';
import 'package:traveloka/view/hotel/hotel_view_header_buttons.dart';
import 'dart:math' as math;
// import 'package:google_maps/google_maps.dart' as maps;
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../components/hotel_card.dart';
import '../../config/primitive_wrapper.dart';
import '../../config/ui_configs.dart';
import '../../entity/hotel.dart';
import '../booking/booking_detail_view.dart';

class MyHotelPage extends StatefulWidget {
  const MyHotelPage({
    super.key,
    required this.hotel,
  });

  final Hotel hotel;

  @override
  State<MyHotelPage> createState() => _MyHotelPageState();
}

class _MyHotelPageState extends State<MyHotelPage> {
  late bool isSaved = false;
  String heroImageURL = '';
  double imageSpacing = 4;

  final reviewsKey = GlobalKey();
  final descriptionKey = GlobalKey();
  // Widget getMap() {
  //   ui.platformViewRegistry.registerViewFactory("6", (int viewId) {
  //     final latlang = maps.LatLng(12.9, 77.65);

  //     final elem = DivElement()
  //       ..id = "6"
  //       ..style.width = "100%"
  //       ..style.height = "100%"
  //       ..style.border = "none";

  //     final mapOptions = maps.MapOptions()
  //       ..zoom = 11
  //       ..tilt = 90
  //       ..center = latlang;

  //     final map = maps.GMap(elem, mapOptions);
  //   });
  // }

  // final elem = DivElement()
  //   ..id = "6"
  //   ..style.width = "100%"
  //   ..style.height = "100%"
  //   ..style.border = "none";

  // final mapOptions = maps.MapOptions()
  //   ..zoom = 11
  //   ..tilt = 90
  //   ..center = maps.LatLng(12.9, 77.65);

  @override
  void initState() {
    heroImageURL = widget.hotel.imageURLs[0];
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
      // appBar: AppBar(title: const Text('Search')),
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
                    // const GoogleMap(
                    //   initialCameraPosition: CameraPosition(
                    //     target: LatLng(25.782337702478927, -80.14071738317143),
                    //   ),
                    // ),
                    // Container(
                    //   height: 300,
                    //   child: map(),
                    // ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingDetailPage(hotel: widget.hotel),
                    )).then((value) => setState(() {}));
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
                        color: UIConfig.black.withOpacity(.5),
                        child: Center(
                          child: Text(
                            '+${widget.hotel.imageURLs.length - 4}',
                            style: TextStyle(
                              fontSize: 16,
                              color: UIConfig.white,
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

  // Container headerButtons(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 20),
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         GestureDetector(
  //           onTap: () => Navigator.pop(context),
  //           child: Icon(
  //             Icons.arrow_back_rounded,
  //             color: UIConfig.white,
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             GestureDetector(
  //               onTap: () async {
  //                 await UserFirebase.saveHotel(widget.hotel.id, isSaved);
  //                 setState(() {
  //                   isSaved = !isSaved;
  //                 });
  //               },
  //               child: AnimatedCrossFade(
  //                 firstChild: Icon(
  //                   Icons.bookmark_border_rounded,
  //                   color: UIConfig.white,
  //                 ),
  //                 secondChild: Icon(
  //                   Icons.bookmark_rounded,
  //                   color: UIConfig.white,
  //                 ),
  //                 crossFadeState: isSaved
  //                     ? CrossFadeState.showSecond
  //                     : CrossFadeState.showFirst,
  //                 duration: const Duration(milliseconds: 200),
  //               ),
  //             ),
  //             const SizedBox(width: 16),
  //             Icon(
  //               Icons.share_rounded,
  //               color: UIConfig.white,
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
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
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          // child: Image.network(widget.hotel.mapURL),
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
              // function: () {
              // print('test');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         BookingDetailPage(hotel: widget.hotel),
              //   ),
              // ).then((_) => widget.createState());
              // },
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

// Widget map() {
//   //A unique id to name the div element
//   String htmlId = "6";
//   //creates a webview in dart
//   //ignore: undefined_prefixed_name
//   ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//     final latLang = maps.LatLng(25.782331531688957, -80.1425676581279);
//     //class to create a div element

//     final mapOptions = maps.MapOptions()
//       ..zoom = 13
//       ..tilt = 90
//       ..center = latLang;
//     final elem = DivElement()
//       ..id = htmlId
//       ..style.width = "100%"
//       ..style.height = "100%"
//       ..style.border = "none";

//     final map = maps.GMap(elem, mapOptions);
//     // Marker(MarkerOptions()
//     //   ..position = latLang
//     //   ..map = map
//     //   ..title = 'My position');
//     // Marker(MarkerOptions()
//     //   ..position = LatLng(12.9557616, 77.7568832)
//     //   ..map = map
//     //   ..title = 'My position');
//     return elem;
//   });
//   //creates a platform view for Flutter Web
//   return HtmlElementView(
//     viewType: htmlId,
//   );
// }

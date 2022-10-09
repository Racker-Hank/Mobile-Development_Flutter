// import 'dart:html';
// import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:traveloka/components/button.dart';
import 'dart:math' as math;
// import 'package:google_maps/google_maps.dart' as maps;
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../components/hotel_card.dart';
import '../config/ui_configs.dart';
import '../entity/hotel.dart';
import '../main.dart';

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
  bool isSaved = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Search')),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'hotel${widget.hotel.id}_image',
                    child: Container(
                      height: 250,
                      foregroundDecoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.hotel.imageURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                  )
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
                              location: widget.hotel.location),
                        ),
                        Ratings(ratings: widget.hotel.ratings),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
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
                            padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
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
                            padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
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
                    ),
                    const SizedBox(height: 16),
                    Container(
                      key: descriptionKey,
                      child: Description(description: widget.hotel.description),
                    ),

                    const SizedBox(height: 16),
                    Facilities(
                      showFacilities: true,
                      facilities: HotelCard.facilities,
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
                    Column(
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
                        const SizedBox(height: 16),
                        // Container(
                        //   height: 1,
                        //   color: UIConfig.primaryColor,
                        // ),
                        Reviews(reviewsKey: reviewsKey, widget: widget),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
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
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: '/Night',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Button(
                    function: () {
                      print('test');
                    },
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
          )
        ],
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
    return Column(
      key: reviewsKey,
      children: widget.hotel.reviews
          .map((e) => ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        leading: const CircleAvatar(radius: 20),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  for (var i = 0; i < 4; i++)
                    Icon(
                      Icons.star_rounded,
                      color: UIConfig.accentColor,
                      size: 20,
                    ),
                  for (var i = 4; i < 5; i++)
                    Icon(
                      Icons.star_rounded,
                      color: UIConfig.darkGrey,
                      size: 20,
                    ),
                ],
              ),
              const Text('UserName'),
            ],
          ),
        ),
        subtitle: Text(
          e,
          style: UIConfig.bodyMediumTextStyle,
        ),
      ))
          .toList(),
    );
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
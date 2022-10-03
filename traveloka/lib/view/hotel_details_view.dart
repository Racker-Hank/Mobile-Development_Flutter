import 'package:flutter/material.dart';
<<<<<<< HEAD:traveloka/lib/view/hotel_details_view.dart
import 'package:traveloka/components/location_card.dart';
import 'package:traveloka/main.dart';
import 'package:traveloka/view/explore_view.dart';

class MyHotelDetailsPage extends StatefulWidget {
  const MyHotelDetailsPage({Key? key}) : super(key: key);

  @override
  State<MyHotelDetailsPage> createState() => _MyHotelDetailsPageState();
}

class _MyHotelDetailsPageState extends State<MyHotelDetailsPage> {
=======

import '../components/location_card.dart';
import '../main.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863:traveloka/lib/view/booking_view.dart
  @override
  Widget build(BuildContext context) {
    // return const Text('Index 1: Booking');
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(
      //   PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) => const Home(),
      //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //       return child;
      //     },
      //   ),
      // ),

      onTap: () => Navigator.pop(context),
      child: Scaffold(
        // appBar: AppBar(title: const Text('Search')),
        body: Column(
          children: [
            Hero(
              tag: 'hotel4_image',
              child: Container(
                height: 300,
                foregroundDecoration: const BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadLine(hotelName: 'asdf', location: 'asdfdfdfa'),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Ratings(ratings: 2),
                      Price(price: 4574),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Description(description: 'awegaweg'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

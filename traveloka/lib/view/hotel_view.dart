import 'package:flutter/material.dart';

import '../components/hotel_card.dart';

class MyHotelPage extends StatefulWidget {
  const MyHotelPage({Key? key}) : super(key: key);

  @override
  State<MyHotelPage> createState() => _MyHotelPageState();
}

class _MyHotelPageState extends State<MyHotelPage> {
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
                    children: [
                      const Ratings(ratings: 2),
                      const Price(price: 4574),
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

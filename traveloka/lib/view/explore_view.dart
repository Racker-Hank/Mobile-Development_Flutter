import 'package:flutter/material.dart';
import 'package:traveloka/components/button.dart';
import 'package:traveloka/config/UI_configs.dart';

import '../components/location_card.dart';
import '../entity/hotel.dart';

class MyExplorePage extends StatefulWidget {
  const MyExplorePage({Key? key}) : super(key: key);

  @override
  State<MyExplorePage> createState() => _MyExplorePageState();
}

class _MyExplorePageState extends State<MyExplorePage> {
  static Hotel hotel1 = const Hotel(
      'https://images.unsplash.com/photo-1561501900-3701fa6a0864?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Resort',
      'Miami',
      4.5,
      500,
      'noice');
  static Hotel hotel2 = const Hotel(
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Resort 2',
      'Miami 2',
      4.1,
      400,
      'noice 2');
  static Hotel hotel3 = const Hotel(
      'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
      'Florida Getaway',
      'Florida villa',
      3.8,
      200,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');
  static Hotel hotel4 = const Hotel(
      'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Deluxe',
      'Miami 5 star luxury hotel',
      4.8,
      800,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');

  final List hotels = [hotel4, hotel3, hotel1, hotel2];

  @override
  Widget build(BuildContext context) {
    // return const Text(
    //   'Index 0: Explore'
    // );
    return Scaffold(
      body: ListView.separated(
          itemCount: hotels.length,
          separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
          addAutomaticKeepAlives: false,
          cacheExtent: 100,
          padding: const EdgeInsets.symmetric(vertical: 30),
          itemBuilder: ((context, i) {
            return Column(
              children: [
                LocationCard(
                  imageURL: hotels[i].imageURL,
                  hotelName: hotels[i].hotelName,
                  location: hotels[i].location,
                  ratings: hotels[i].ratings,
                  price: hotels[i].price,
                  description: hotels[i].description,
                ),
                const Button(),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    print('test');
                  },
                  child: Button(
                    label: 'Book Now',
                    icon: Icon(Icons.arrow_forward_rounded,
                        color: UIConfig.white),
                    showIcon: true,
                  ),
                ),
              ],
            );
          })),
    );
  }
}
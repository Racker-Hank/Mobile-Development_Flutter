import 'package:flutter/material.dart';
import 'package:traveloka/components/location_card.dart';
import 'package:traveloka/view/hotel_details_view.dart';

import '../components/search_bar.dart';
import '../entity/hotel.dart';

class MySearchPage extends StatefulWidget {
  const MySearchPage({Key? key}) : super(key: key);

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  // dummy data
  static Hotel hotel1 = const Hotel(
      1,
      'https://images.unsplash.com/photo-1561501900-3701fa6a0864?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Resort',
      'Miami',
      4.5,
      500,
      'noice');
  static Hotel hotel2 = const Hotel(
      2,
      'https://images.unsplash.com/photo-1540541338287-41700207dee6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Resort 2',
      'Miami 2',
      4.1,
      400,
      'noice 2');
  static Hotel hotel3 = const Hotel(
      3,
      'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80',
      'Florida Getaway',
      'Florida villa',
      3.8,
      200,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');
  static Hotel hotel4 = const Hotel(
      4,
      'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
      'Miami Deluxe',
      'Miami 5 star luxury hotel',
      4.8,
      800,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor');

  final List hotels = [hotel4, hotel3, hotel1, hotel2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchBar(),
          const SizedBox(height: 16,),
          Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, i) {
                    return Column(
                      children: [
                        LocationCard(
                          hotelID: hotels[i].id,
                          imageURL: hotels[i].imageURL,
                          hotelName: hotels[i].hotelName,
                          location: hotels[i].location,
                          ratings: hotels[i].ratings,
                          price: hotels[i].price,
                          description: hotels[i].description,
                        ),
                      ],
                    );
                  }),
                  separatorBuilder: (context, index) => const SizedBox(height: 16,),
                  itemCount: hotels.length
              )
          )
        ],
      ),
    );
  }
}

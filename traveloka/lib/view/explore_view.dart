import 'package:flutter/material.dart';
import '../components/button.dart';
import '../components/round_icon_button.dart';
import '../config/ui_configs.dart';

import '../components/hotel_card.dart';
import '../components/search_bar.dart';
import '../entity/hotel.dart';

class MyExplorePage extends StatefulWidget {
  const MyExplorePage({Key? key}) : super(key: key);

  @override
  State<MyExplorePage> createState() => _MyExplorePageState();
}

class _MyExplorePageState extends State<MyExplorePage> {
  final double hPadding = 16;

  List hotels = Hotel.hotels;

  @override
  Widget build(BuildContext context) {
    // return const Text(
    //   'Index 0: Explore'
    // );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchBar(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: hotels.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            addAutomaticKeepAlives: false,
            cacheExtent: 100,
            // padding: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.only(bottom: 16),
            itemBuilder: ((context, i) {
              return Column(
                children: [
                  HotelCard(
                    hotel: hotels[i],
                    // hotelID: hotels[i].id,
                    // imageURL: hotels[i].imageURL,
                    // hotelName: hotels[i].name,
                    // location: hotels[i].location,
                    // ratings: hotels[i].ratings,
                    // price: hotels[i].price,
                    // description: hotels[i].description,
                    showFacilities: false,
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
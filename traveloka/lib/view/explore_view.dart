import 'package:flutter/material.dart';
import 'package:traveloka/repositories/hotel_data.dart';
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

  // List hotels = Hotel.hotels;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchBar(),
        const SizedBox(height: 16),
        Expanded(
          child: StreamBuilder<List<Hotel>>(
            stream: HotelFirebase.readHotels(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.active) {
                final hotels = snapshot.data!;
                // return Text(hotels.length.toString());
                return ListView.separated(
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
                          showFacilities: false,
                        ),
                      ],
                    );
                  }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                  // child: Text(snapshot.connectionState.toString()),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:traveloka/entity/hotel.dart';
import '../components/hotel_tile.dart';
import '../components/search_bar.dart';
import '../config/UI_configs.dart';
// import '../entity/hotel.dart';
import '../repositories/hotel_data.dart';

class MySavedPage extends StatefulWidget {
  const MySavedPage({Key? key}) : super(key: key);

  @override
  State<MySavedPage> createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchBar(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Saved',
              style: UIConfig.indicationTextStyle,
            ),
          ]),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder<List<Hotel>>(
            stream: HotelFirebase.readHotels(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.active) {
                final hotels = snapshot.data!;
                // return Text(hotels.length.toString());
                return hotels.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                          child: Text(
                            'You have not saved any hotel.',
                            style: TextStyle(
                                color: UIConfig.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: hotels.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 8,
                        ),
                        addAutomaticKeepAlives: false,
                        cacheExtent: 100,
                        padding: const EdgeInsets.only(bottom: 16),
                        itemBuilder: ((context, i) {
                          return HotelTile(hotel: hotels[i]);
                        }),
                      );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

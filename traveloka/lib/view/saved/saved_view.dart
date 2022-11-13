import 'package:flutter/material.dart';
import 'package:traveloka/entity/hotel.dart';
import '../../components/hotel_tile.dart';
import '../../components/search_bar.dart';
import '../../config/ui_configs.dart';
import '../../repositories/hotel_data.dart';
import '../../repositories/user_data.dart';

class MySavedPage extends StatefulWidget {
  const MySavedPage({Key? key}) : super(key: key);

  @override
  State<MySavedPage> createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  Future<List<Hotel>> initSavedHotels(List<String> savedHotelsId) async {
    List<Hotel> savedHotels = [];

    for (String hotelId in savedHotelsId) {
      await HotelFirebase.getHotelById(hotelId).then((value) {
        savedHotels.add(value);
      });
    }
    return savedHotels.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SearchBar(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Saved',
                style: UIConfig.indicationTextStyle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: StreamBuilder<List<String>>(
            stream: UserFirebase.readSavedHotelsId(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.active) {
                return FutureBuilder(
                    future: initSavedHotels(snapshot.data!),
                    builder: (context, futureSnapshot) {
                      if (futureSnapshot.connectionState ==
                          ConnectionState.done) {
                        List<Hotel> savedHotels = futureSnapshot.data!;

                        return savedHotels.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                itemCount: savedHotels.length,
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 8,
                                ),
                                addAutomaticKeepAlives: false,
                                cacheExtent: 100,
                                padding: const EdgeInsets.only(bottom: 16),
                                itemBuilder: ((context, i) {
                                  return HotelTile(hotel: savedHotels[i]);
                                  // return Text('test');
                                }),
                              );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                    });
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

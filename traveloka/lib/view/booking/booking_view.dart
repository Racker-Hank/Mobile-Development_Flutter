import 'package:flutter/material.dart';
import 'package:traveloka/components/hotel_tile.dart';
import 'package:traveloka/config/ui_configs.dart';
import 'package:traveloka/entity/hotel.dart';
import 'package:traveloka/repositories/booking_data.dart';
import 'package:traveloka/repositories/hotel_data.dart';
import 'package:traveloka/repositories/user_data.dart';
import '../../components/search_bar.dart';
import '../../entity/booking.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  static String userId = UserFirebase.userId;
  Future<List<Hotel>> initBookedHotels(List<String> bookedHotelsId) async {
    List<Hotel> bookedHotels = [];

    for (String hotelId in bookedHotelsId) {
      await HotelFirebase.getHotelById(hotelId)
          .then((value) => bookedHotels.add(value));
    }

    return bookedHotels;
  }

  Stream<List<Booking>> bookingsStream = BookingFirebase.readBookingsByUserId(userId);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SearchBar(),
            const SizedBox(height: 16),
            StreamBuilder<List<Booking>>(
              stream: bookingsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.connectionState == ConnectionState.active) {
                  final bookings = snapshot.data!;
                  final bookedHotelIds = bookings
                      .where((booking) => booking.bookingFromDate.compareTo(DateTime.now()) > 0)
                      .map((booking) => booking.hotelId).toList();

                  return bookedHotelIds.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Text(
                              'You have no pending booking.',
                              style: TextStyle(
                                color: UIConfig.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                      )
                      : FutureBuilder(
                          future: initBookedHotels(bookedHotelIds),
                          builder: (context, futureSnapshot) {
                            if(futureSnapshot.connectionState == ConnectionState.done) {
                              List<Hotel> hotels = futureSnapshot.data!;

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Currently booking',
                                          style: UIConfig.indicationTextStyle,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'See more',
                                              style: UIConfig.indicationTextStyle,
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_right_rounded,
                                              color: UIConfig.accentColor,
                                              size: 24,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ListView.separated(
                                    itemCount: hotels.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 8,
                                    ),
                                    addAutomaticKeepAlives: false,
                                    cacheExtent: 100,
                                    padding: const EdgeInsets.only(bottom: 16),
                                    itemBuilder: ((context, i) {
                                      return HotelTile(
                                        hotel: hotels[i],
                                        booking: bookings[i],
                                        showBooking: true,
                                      );
                                    }),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          },
                      );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            StreamBuilder<List<Booking>>(
              stream: bookingsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.connectionState == ConnectionState.active) {
                  final bookings = snapshot.data!;
                  final bookedHotelIds = snapshot.data!.map((booking) => booking.hotelId).toList();

                  return bookedHotelIds.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                           child: Center(
                             child: Text(
                              'You have not booked any hotel.',
                              style: TextStyle(
                                color: UIConfig.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'
                              ),
                              textAlign: TextAlign.center,
                            ),
                           ),
                      )
                      : FutureBuilder(
                          future: initBookedHotels(bookedHotelIds),
                          builder: (context, futureSnapshot) {
                            if (futureSnapshot.connectionState == ConnectionState.done) {
                              List<Hotel> hotels = futureSnapshot.data!;

                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Recently booked',
                                          style: UIConfig.indicationTextStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ListView.separated(
                                    itemCount: hotels.length,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 8,
                                    ),
                                    addAutomaticKeepAlives: false,
                                    cacheExtent: 100,
                                    padding: const EdgeInsets.only(bottom: 16),
                                    itemBuilder: ((context, i) {
                                      return HotelTile(
                                        hotel: hotels[i],
                                        booking: bookings[i],
                                        showBooking: true,
                                      );
                                    }),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                          }
                        );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ],
        )
    );
  }
}

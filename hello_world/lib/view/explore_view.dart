import 'package:flutter/material.dart';
import 'package:hello_world/components/button.dart';
import 'package:hello_world/config/UI_configs.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const MyHeader(),
        Expanded(
            child: ListView.separated(
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
                    ],
                  );
                })
            )
        )
      ],
              // const Button(),
              // const SizedBox(
              //   height: 8,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     print('test');
              //   },
              //   child: Button(
              //     label: 'Book Now',
              //     icon: Icon(Icons.arrow_forward_rounded,
              //         color: UIConfig.white),
              //     showIcon: true,
              //   ),
              // ),

    );
  }
}

class MyHeader extends StatefulWidget {
  const MyHeader({Key? key}) : super(key: key);

  @override
  State<MyHeader> createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder()
              ),
              onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Icon(
                    Icons.notifications,
                    color: UIConfig.unselectedColor,
                  ),
                )
            ),
          ),
          Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Search for a place or location",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 6, top: 7, bottom: 7, right: 10),
                    child: Icon(Icons.search)
                  )
                ),
              )
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: Icon(
                  Icons.chat_bubble,
                  color: UIConfig.unselectedColor,
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}


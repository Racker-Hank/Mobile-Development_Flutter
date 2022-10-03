import 'package:flutter/material.dart';
import 'package:traveloka/components/readonly_search_bar.dart';
import 'package:traveloka/view/hotel_details_view.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        ReadOnlySearchBar(),
      ],
    );
  }
}

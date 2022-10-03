import 'package:flutter/material.dart';
import 'package:traveloka/view/booking_view.dart';
import 'package:traveloka/view/search_view.dart';
import 'config/UI_configs.dart';
import 'view/explore_view.dart';
import 'view/profile_view.dart';
import 'view/saved_view.dart';
import 'view/hotel_details_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Traveloka',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: UIConfig.screenBackgroundColor,
      primarySwatch: Colors.blue,
    ),
    home: const Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const List<Widget> _viewOption = <Widget>[
    MyExplorePage(),
    MyBookingPage(),
    //MySearchPage(),
    MySavedPage(),
    MyProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _viewOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.maps_home_work),
              label: 'Booking'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Saved'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          )
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: UIConfig.primaryColor),
        unselectedItemColor: UIConfig.darkGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}

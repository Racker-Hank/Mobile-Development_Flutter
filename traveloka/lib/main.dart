import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/ui_configs.dart';
import 'firebase_options.dart';
import 'view/booking_view.dart';
import 'view/explore_view.dart';
import 'view/profile_view.dart';
import 'view/saved_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _viewOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.maps_home_work), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Color(0xFF1CA0E3)),
        unselectedItemColor: const Color(0xFF79747E),
        onTap: _onItemTapped,
      ),
    );
  }
}

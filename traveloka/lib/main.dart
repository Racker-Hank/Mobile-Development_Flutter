import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:traveloka/components/bottom_nav_bar.dart';
import 'package:traveloka/config/UI_configs.dart';
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
  int _selectedIndex = 1;

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _viewOption.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
    );
  }
}

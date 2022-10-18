import 'package:flutter/material.dart';
import 'package:traveloka/config/UI_configs.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  final int selectedIndex;
  final Function(int) onItemTapped;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 4,
            color: UIConfig.black.withOpacity(.15),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_rounded),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_rounded),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          )
        ],
        currentIndex: widget.selectedIndex,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontFamily: 'Roboto',
        ),
        unselectedLabelStyle: const TextStyle(
          letterSpacing: 1,
          fontFamily: 'Roboto',
        ),
        selectedItemColor: Colors.black,
        selectedIconTheme: IconThemeData(color: UIConfig.primaryColor),
        unselectedItemColor: UIConfig.darkGrey,
        onTap: widget.onItemTapped,
      ),
    );
  }
}

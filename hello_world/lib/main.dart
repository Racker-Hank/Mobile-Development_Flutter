import 'package:flutter/material.dart';
import 'view/explore_view.dart';
import 'view/profile_view.dart';
import 'view/saved_view.dart';
import 'view/search_view.dart';

void main() {
  runApp(MaterialApp(
    title: 'Traveloka',
    theme: ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.blue,
    ),
    home: const MyBottomNavigationBar(),
  ));
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _viewOption = <Widget>[
    MyExplorePage(),
    MySearchPage(),
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


// class MyCustomForm extends StatelessWidget {
//   const MyCustomForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Enter a search term'
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: TextFormField(
//             decoration: const InputDecoration(
//               border: UnderlineInputBorder(),
//               labelText: 'Enter your username',
//             ),
//           ),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: MyCheckboxWidget(),
//         ),
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//           child: MyDropdownWidget(),
//         ),
//       ],
//     );
//   }
// }
//
// class MyCheckboxWidget extends StatefulWidget {
//   const MyCheckboxWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyCheckboxWidget> createState() => _MyCheckboxWidgetState();
// }
//
// class _MyCheckboxWidgetState extends State<MyCheckboxWidget> {
//   bool isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused
//       };
//
//       if(states.any(interactiveStates.contains)) {
//         return Colors.blue;
//       }
//       return Colors.red;
//     }
//
//     return Checkbox(
//       checkColor: Colors.white,
//       fillColor: MaterialStateProperty.resolveWith(getColor),
//       value: isChecked,
//       onChanged: (bool? value) {
//         setState(() {
//           isChecked = value!;
//         });
//       }
//     );
//   }
// }
//
// class MyDropdownWidget extends StatefulWidget {
//   const MyDropdownWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyDropdownWidget> createState() => _MyDropdownWidgetState();
// }
//
// class _MyDropdownWidgetState extends State<MyDropdownWidget> {
//   static const List<String> list = <String>['Freshman', 'Sophomore', 'Junior', 'Senior'];
//   String dropdownValue = list.first;
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_drop_down),
//       elevation: 16,
//       underline: Container(
//         height: 2,
//         color: Colors.blue,
//       ),
//       items: list.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value)
//         );
//       }).toList(),
//       onChanged: (String? value) {
//         setState(() {
//           dropdownValue = value!;
//         });
//       }
//     );
//   }
// }

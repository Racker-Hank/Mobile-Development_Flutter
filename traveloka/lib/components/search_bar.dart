import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:traveloka/components/round_icon_button.dart';

import '../config/UI_configs.dart';
import 'button.dart';
=======
import './button.dart';
import './round_icon_button.dart';

import '../config/UI_configs.dart';
import '../view/search_view.dart';
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
=======
  bool isAdvancedSearch = false;

  // FocusNode searchBarFocusNode = FocusNode();
  // FocusNode hotelBoxFocusNode = FocusNode();
  // FocusNode guestsBoxFocusNode = FocusNode();
  // FocusNode rightIconButtonFocusNode = FocusNode();

  // bool isSearchFocussed = false;

  late final TextEditingController _hotel;
  late final TextEditingController _guests;

  Icon leftIcon = Icon(
    Icons.notifications_rounded,
    color: UIConfig.darkGrey,
    size: 20,
  );

  Icon rightIcon = Icon(
    Icons.chat_rounded,
    color: UIConfig.darkGrey,
    size: 20,
  );

  Function() rightIconButtonFunction = () {};

  @override
  void initState() {
    super.initState();
    // searchBarFocusNode.addListener(_onFocusChange);
    // // hotelBoxFocusNode.addListener(_onFocusChange);
    // // guestsBoxFocusNode.addListener(_onFocusChange);
    // rightIconButtonFocusNode.addListener(_onFocusChange);

    _hotel = TextEditingController();
    _guests = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // hotelBoxFocusNode.dispose();
    // guestsBoxFocusNode.dispose();
    _hotel.dispose();
    _guests.dispose();
  }

  void _onFocusChange() {
    // print(searchBarFocusNode.hasFocus);
    // print(searchBarFocusNode.traversalChildren);

    // setState(() {
    //   isSearchFocussed =
    //       // hotelBoxFocusNode.hasFocus || guestsBoxFocusNode.hasFocus;
    //       searchBarFocusNode.hasFocus;

    //   if (isSearchFocussed) {
    leftIcon = Icon(
      Icons.arrow_back_rounded,
      color: UIConfig.darkGrey,
      size: 20,
    );
    rightIcon = Icon(
      Icons.tune_rounded,
      color: UIConfig.primaryColor,
      size: 20,
    );
    // } else {
    leftIcon = Icon(
      Icons.notifications_rounded,
      color: UIConfig.darkGrey,
      size: 20,
    );
    rightIcon = Icon(
      Icons.chat_rounded,
      color: UIConfig.darkGrey,
      size: 20,
    );
  }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.only(right: 16),
    //         child: ElevatedButton(
    //             onPressed: () {}, child: const Icon(Icons.notifications)),
    //       ),
    //       Expanded(
    //           child: TextFormField(
    //         decoration: const InputDecoration(
    //             border: UnderlineInputBorder(),
    //             labelText: "Search for a place or location",
    //             prefixIcon: Padding(
    //                 padding:
    //                     EdgeInsets.only(left: 6, top: 7, bottom: 7, right: 10),
    //                 child: Icon(Icons.search))),
    //       )),
    //       Container(
    //         padding: const EdgeInsets.only(left: 16),
    //         child: ElevatedButton(
    //           onPressed: () {},
    //           child: const Icon(Icons.chat_bubble),
    //         ),
    //       )
    //     ],
    //   ),
    // );
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
              GestureDetector(
                child: const LeftRoundIconButton(),
                onTap: () {
                  Navigator.pop(context);
                }
=======
              LeftRoundIconButton(
                icon: leftIcon,
                function: () {},
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
<<<<<<< HEAD
                  children: const [
                    SearchBox(),
=======
                  children: [
                    SearchBox(
                      controller: _hotel,
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: UIConfig.primaryColor,
                        size: 20,
                      ),
                      suffix: Align(
                        alignment: Alignment.centerRight,
                        widthFactor: 1,
                        child: GestureDetector(
                          onTap: () {
                            _hotel.text = '';
                          },
                          child: const Icon(
                            Icons.cancel_rounded,
                            color: Color(0xFF79747e),
                            size: 16,
                          ),
                        ),
                      ),
                      hintText: 'traveloka🚀',
                      labelText: 'Search for a location',
                      // focusNode: hotelBoxFocusNode,
                      focussed: () {
                        // print("test");
                        // setState(() {
                        //   leftIcon = Icon(
                        //     Icons.arrow_back_rounded,
                        //     color: UIConfig.darkGrey,
                        //   );
                        //   rightIcon = Icon(
                        //     Icons.tune_rounded,
                        //     color: UIConfig.primaryColor,
                        //     size: 20,
                        //   );
                        //   // print(searchBoxFocusNode.hasFocus);
                        // });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MySearchPage(),
                          ),
                        );
                      },
                    ),
                    // Visibility(
                    //   visible: isAdvancedSearch,
                    //   // replacement: ,
                    //   child: Column(
                    //     children: [
                    //       const SizedBox(height: 16),
                    //       SearchBox(
                    //         controller: _guests,
                    //         prefixIcon: Icon(
                    //           Icons.people_rounded,
                    //           color: UIConfig.primaryColor,
                    //           size: 20,
                    //         ),
                    //         labelText: 'Guests',
                    //         hintText: 2,
                    //         keyboardType: TextInputType.number,
                    //         suffix: Row(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             GestureDetector(
                    //               onTap: () {
                    //                 int guests = int.parse(
                    //                     _guests.text.isNotEmpty
                    //                         ? _guests.text
                    //                         : '0');
                    //                 guests++;
                    //                 _guests.text = '$guests';
                    //               },
                    //               child: Icon(
                    //                 Icons.add_rounded,
                    //                 color: UIConfig.primaryColor,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //             Text(
                    //               '|',
                    //               style: TextStyle(color: UIConfig.darkGrey),
                    //             ),
                    //             GestureDetector(
                    //               onTap: () {
                    //                 int guests = int.parse(
                    //                     _guests.text.isNotEmpty
                    //                         ? _guests.text
                    //                         : '0');
                    //                 if (guests > 1) {
                    //                   guests--;
                    //                   _guests.text = '$guests';
                    //                 } else {}
                    //               },
                    //               child: Icon(
                    //                 Icons.remove_rounded,
                    //                 color: UIConfig.primaryColor,
                    //                 size: 20,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         // focusNode: guestsBoxFocusNode,
                    //         focussed: () {},
                    //       ),
                    //     ],
                    //   ),
                    // ),
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
                  ],
                ),
              ),
              const SizedBox(width: 16),
<<<<<<< HEAD
              const RightRoundIconButton(),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              print('Search');
            },
            child: const Button(),
=======
              RightRoundIconButton(
                icon: rightIcon,
                function: () {
                  // rightIconButtonFocusNode.requestFocus();
                },
                // focusNode: rightIconButtonFocusNode,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Button(
            function: () {
              print('${_hotel.text} ${_guests.text}');
            },
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
<<<<<<< HEAD
  }) : super(key: key);

=======
    required this.focussed,
    this.focusNode,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.suffix,
    this.keyboardType,
    required this.controller,
  }) : super(key: key);

  final Function() focussed;
  final FocusNode? focusNode;
  final Icon prefixIcon;
  final dynamic hintText;
  final String labelText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextEditingController controller;

>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 36,
      decoration: BoxDecoration(
<<<<<<< HEAD
          borderRadius: UIConfig.borderRadius,
          color: UIConfig.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(15, 0, 0, 0),
              offset: Offset(0, 6),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Color.fromARGB(30, 0, 0, 0),
              offset: Offset(0, 2),
              blurRadius: 3,
            ),
          ]),
      child: TextField(
        autofocus: true,
        onTap: () {},
        decoration: InputDecoration(
=======
        borderRadius: UIConfig.borderRadius,
        color: UIConfig.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(30, 0, 0, 0),
            offset: Offset(0, 2),
            blurRadius: 3,
          ),
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            offset: Offset(0, 6),
            blurRadius: 10,
            spreadRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onTap: focussed,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: '$hintText',
          hintStyle: const TextStyle(
            color: Color(0xFFB9B9B9),
          ),
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: UIConfig.borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: UIConfig.primaryColor),
            borderRadius: UIConfig.borderRadius,
          ),
<<<<<<< HEAD
          labelText: "Search for a location",
=======
          labelText: labelText,
          // label: const Padding(
          //   padding: EdgeInsets.only(bottom: 4),
          //   child: Text("Search for a location"),
          // ),
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
          // labelStyle: TextStyle(
          //   fontFamily: 'Nunito Sans',
          //   fontSize: 18,
          //   color: UIConfig.primaryColor,
          // ),
<<<<<<< HEAD
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: UIConfig.primaryColor,
            size: 20,
          ),
=======
          contentPadding: const EdgeInsets.only(right: 8),
          prefixIcon: prefixIcon,
          suffix: suffix,
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
        ),
        style: UIConfig.textFieldInputTextStyle,
      ),
    );
  }
}

class LeftRoundIconButton extends StatelessWidget {
  const LeftRoundIconButton({
    Key? key,
<<<<<<< HEAD
  }) : super(key: key);

=======
    required this.icon,
    required this.function,
    this.focusNode,
  }) : super(key: key);

  final Icon icon;
  final Function() function;
  final FocusNode? focusNode;

>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: RoundIconButton(
<<<<<<< HEAD
        icon: Icon(
          Icons.arrow_back,
          color: UIConfig.darkGrey,
        )
=======
        icon: icon,
        function: function,
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
      ),
    );
  }
}

class RightRoundIconButton extends StatelessWidget {
  const RightRoundIconButton({
    Key? key,
<<<<<<< HEAD
  }) : super(key: key);

=======
    required this.icon,
    required this.function,
    this.focusNode,
  }) : super(key: key);

  final Icon icon;
  final Function() function;
  final FocusNode? focusNode;

>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: RoundIconButton(
<<<<<<< HEAD
          icon: Icon(
            Icons.filter_alt,
            color: UIConfig.primaryColor,
            size: 20,
          )),
    );
  }
}
=======
        icon: icon,
        function: function,
        focusNode: focusNode,
      ),
    );
  }
}
>>>>>>> 8aaf43333c559ca83d58acd9b5768590b130f863

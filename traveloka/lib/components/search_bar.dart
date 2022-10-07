import 'dart:async';

import 'package:flutter/material.dart';
import 'package:traveloka/main.dart';
import './button.dart';
import './round_icon_button.dart';

import '../config/ui_configs.dart';
import '../view/search_view.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isAdvancedSearch = false;
  // late AnimationController _animationController;

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
    // _animationController = AnimationController(
    //     vsync: this,
    //     duration: const Duration(milliseconds: 150)
    // );
    // Timer(const Duration(milliseconds: 200), () => _animationController.forward());

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
    // _animationController.dispose();
    _hotel.dispose();
    _guests.dispose();
  }

  // void _onFocusChange() {
  //   // print(searchBarFocusNode.hasFocus);
  //   // print(searchBarFocusNode.traversalChildren);

  //   // setState(() {
  //   //   isSearchFocussed =
  //   //       // hotelBoxFocusNode.hasFocus || guestsBoxFocusNode.hasFocus;
  //   //       searchBarFocusNode.hasFocus;

  //   //   if (isSearchFocussed) {
  //   leftIcon = Icon(
  //     Icons.arrow_back_rounded,
  //     color: UIConfig.darkGrey,
  //     size: 20,
  //   );
  //   rightIcon = Icon(
  //     Icons.tune_rounded,
  //     color: UIConfig.primaryColor,
  //     size: 20,
  //   );
  //   // } else {
  //   leftIcon = Icon(
  //     Icons.notifications_rounded,
  //     color: UIConfig.darkGrey,
  //     size: 20,
  //   );
  //   rightIcon = Icon(
  //     Icons.chat_rounded,
  //     color: UIConfig.darkGrey,
  //     size: 20,
  //   );
  // }
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeftRoundIconButton(
                icon: leftIcon,
                function: () {},
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MySearchPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
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
          // Button(
          //   function: () {
          //     print('${_hotel.text} ${_guests.text}');
          //   },
          // ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      height: 36,
      decoration: BoxDecoration(
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
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: UIConfig.borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: UIConfig.primaryColor),
            borderRadius: UIConfig.borderRadius,
          ),
          labelText: labelText,
          contentPadding: const EdgeInsets.only(right: 8),
          prefixIcon: prefixIcon,
          suffix: suffix,
        ),
        style: UIConfig.textFieldInputTextStyle,
      ),
    );
  }
}

class LeftRoundIconButton extends StatelessWidget {
  const LeftRoundIconButton({
    Key? key,
    required this.icon,
    required this.function,
    this.focusNode,
  }) : super(key: key);

  final Icon icon;
  final Function() function;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: RoundIconButton(
        icon: icon,
        function: function,
      ),
    );
  }
}

class RightRoundIconButton extends StatelessWidget {
  const RightRoundIconButton({
    Key? key,
    required this.icon,
    required this.function,
    this.focusNode,
  }) : super(key: key);

  final Icon icon;
  final Function() function;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: RoundIconButton(
        icon: icon,
        function: function,
        focusNode: focusNode,
      ),
    );
  }
}
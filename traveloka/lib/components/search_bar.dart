import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './round_icon_button.dart';

import '../config/ui_configs.dart';
import '../view/search_view.dart';
import 'new_page_route.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isAdvancedSearch = false;

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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const MySearchPage(),
                        //   ),
                        // );
                        // Navigator.of(context).push(
                        //   NewPageRoute(
                        //     child: const MySearchPage(),
                        //   ),
                        // );
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: ((context) => const MySearchPage()),
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
    this.onChanged,
  }) : super(key: key);

  final Function() focussed;
  final Function(String)? onChanged;
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
        onChanged: onChanged,
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
          // label: const Padding(
          //   padding: EdgeInsets.only(bottom: 4),
          //   child: Text("Search for a location"),
          // ),
          // labelStyle: TextStyle(
          //   fontFamily: 'Nunito Sans',
          //   fontSize: 18,
          //   color: UIConfig.primaryColor,
          // ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './round_icon_button.dart';

import '../config/ui_configs.dart';
import '../view/search_view.dart';
import 'input_box.dart';
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
    _hotel = TextEditingController();
    _guests = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // hotelBoxFocusNode.dispose();
    // guestsBoxFocusNode.dispose();
    _hotel.dispose();
    _guests.dispose();
    super.dispose();
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
                    InputBox(
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

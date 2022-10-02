import 'package:flutter/material.dart';
import 'package:hello_world/components/button.dart';
import 'package:hello_world/components/round_icon_button.dart';

import '../config/UI_configs.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
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
              const LeftRoundIconButton(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: const [
                    SearchBox(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const RightRoundIconButton(),
            ],
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              print('Search');
            },
            child: const Button(),
          ),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

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
        onTap: () {
          print('textfield');
        },
        decoration: InputDecoration(
          hintText: 'traveloka',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: UIConfig.borderRadius,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: UIConfig.primaryColor),
            borderRadius: UIConfig.borderRadius,
          ),
          labelText: "Search for a location",
          // labelStyle: TextStyle(
          //   fontFamily: 'Nunito Sans',
          //   fontSize: 18,
          //   color: UIConfig.primaryColor,
          // ),
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: UIConfig.primaryColor,
            size: 20,
          ),
        ),
        style: UIConfig.textFieldInputTextStyle,
      ),
    );
  }
}

class LeftRoundIconButton extends StatelessWidget {
  const LeftRoundIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: RoundIconButton(
          icon: Icon(
        Icons.notifications_rounded,
        color: UIConfig.darkGrey,
      )),
    );
  }
}

class RightRoundIconButton extends StatelessWidget {
  const RightRoundIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: RoundIconButton(
          icon: Icon(
        Icons.chat_rounded,
        color: UIConfig.darkGrey,
        size: 20,
      )),
    );
  }
}

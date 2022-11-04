import 'package:flutter/material.dart';

import '../config/ui_configs.dart';

class InputBox extends StatelessWidget {
  const InputBox({
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
    this.onEditingComplete,
    this.obscureText,
    this.autoCorrect,
    this.enableSuggestions,
  }) : super(key: key);

  final Function() focussed;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final FocusNode? focusNode;
  final Icon prefixIcon;
  final dynamic hintText;
  final String labelText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final bool? autoCorrect;
  final bool? enableSuggestions;

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
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText ?? false,
        autocorrect: autoCorrect ?? true,
        enableSuggestions: enableSuggestions ?? true,
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
          // contentPadding: const EdgeInsets.fromLTRB(0, 4, 16, 4),
          prefixIcon: prefixIcon,
          suffix: suffix,
        ),
        style: UIConfig.textFieldInputTextStyle,
      ),
    );
  }
}

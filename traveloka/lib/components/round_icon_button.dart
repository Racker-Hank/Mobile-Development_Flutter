import 'package:flutter/material.dart';

import '../config/ui_configs.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.function,
    this.focusNode,
  });

  final Icon icon;
  final Function() function;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: function,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: UIConfig.white,
            shape: BoxShape.circle,
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
          child: icon,
        ),
      ),
    );
  }
}

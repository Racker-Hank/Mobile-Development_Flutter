import 'package:flutter/material.dart';

import '../config/UI_configs.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({super.key, required this.icon});

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: UIConfig.white,
        shape: BoxShape.circle,
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
        ],
      ),
      child: icon,
    );
  }
}

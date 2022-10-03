import 'package:flutter/material.dart';
import 'package:hello_world/config/UI_configs.dart';
import 'dart:math' as math;

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.label = 'Search',
    this.icon = const Icon(Icons.search, size: 24, color: Colors.white),
    this.showIcon = false,
    required this.function,
  });

  final String label;
  final Icon icon;
  final bool showIcon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: UIConfig.borderRadius,
          gradient: LinearGradient(
            colors: [UIConfig.accentColor, UIConfig.primaryColor],
            transform: const GradientRotation(math.pi / 4),
          ),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: UIConfig.buttonTextStyle,
            ),
            const SizedBox(
              width: 4,
            ),
            if (showIcon) icon,
          ],
        ),
      ),
    );
  }
}

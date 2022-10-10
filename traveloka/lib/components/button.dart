import 'package:flutter/material.dart';
import '../config/ui_configs.dart';
import 'dart:math' as math;

class Button extends StatefulWidget {
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
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _focused = false;
  bool _hovering = false;
  // bool _on = false;
  final List<Color> _colors = [
    const Color(0xFF1ca0e3),
    const Color(0xFF0a97e0),
    const Color(0xFF008edc),
    const Color(0xFF0085d8),
    const Color(0xFF007cd3),
    const Color(0xFF0084d9),
    const Color(0xFF008ddf),
    const Color(0xFF0095e5),
    const Color(0xFF00b1f2),
    const Color(0xFF00cbf7),
    const Color(0xFF00e4f5),
    const Color(0xFF5ffbf1),
  ];

  LinearGradient get defaultGradient {
    return LinearGradient(
      colors: _colors,
      transform: const GradientRotation(math.pi / 4),
    );
  }

  LinearGradient get selectedGradient {
    return LinearGradient(
      colors: _colors
          .map((e) => Color.alphaBlend(Colors.white.withOpacity(.15), e))
          .toList(),
      transform: const GradientRotation(math.pi / 4),
    );
  }

  LinearGradient get gradient {
    LinearGradient gradient;
    if (_focused || _hovering) {
      gradient = selectedGradient;
    } else {
      gradient = defaultGradient;
    }
    return gradient;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: FocusableActionDetector(
        onShowHoverHighlight: (value) => setState(() {
          _hovering = value;
        }),
        onShowFocusHighlight: (value) => setState(() {
          _focused = value;
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: UIConfig.borderRadius,
            // gradient: LinearGradient(
            //   colors: [UIConfig.accentColor, UIConfig.primaryColor],
            //   transform: const GradientRotation(math.pi / 4),
            // ),
            gradient: gradient,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(70, 0, 0, 0),
                offset: Offset(0, 2),
                blurRadius: 3,
              ),
              BoxShadow(
                color: Color.fromARGB(30, 0, 0, 0),
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
                widget.label,
                style: UIConfig.buttonTextStyle,
              ),
              const SizedBox(
                width: 4,
              ),
              if (widget.showIcon) widget.icon,
            ],
          ),
        ),
      ),
    );
  }
}
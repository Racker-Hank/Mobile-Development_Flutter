import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../config/ui_configs.dart';

class CustomClipPath extends StatelessWidget {
  const CustomClipPath({super.key});

  @override
  Widget build(BuildContext context) {
    // return ClipShadowPath(
    return ClipPath(
      // shadow: BoxShadow(
      //   offset: Offset(0, 4),
      //   blurRadius: 4,
      //   // blurStyle: BlurStyle.inner,
      //   color: UIConfig.black.withOpacity(.25),
      // ),
      clipper: MyClipper(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 3 / 5,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              UIConfig.accentColor,
              UIConfig.accentColor.withAlpha(10),
            ],
            transform: const GradientRotation(math.pi / 2),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 55;
    double h = size.height - curveHeight;
    double w = size.width;

    Path path = Path();
    path.lineTo(0, h);
    // path.lineTo(w / 2, h);
    path.quadraticBezierTo(w / 4, h + curveHeight, w / 2, h);
    path.quadraticBezierTo(w / 4 * 3, h - curveHeight, w, h);
    // path.lineTo(w, h);
    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final BoxShadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(child: child, clipper: clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final BoxShadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint()
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        shadow.spreadRadius,
      );
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

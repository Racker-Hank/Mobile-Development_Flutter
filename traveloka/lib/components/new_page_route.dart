import 'package:flutter/material.dart';

class NewPageRoute extends PageRouteBuilder {
  final Widget child;

  NewPageRoute({
    required this.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInCubic)).animate(animation),
      child: child,
    );
  }
}

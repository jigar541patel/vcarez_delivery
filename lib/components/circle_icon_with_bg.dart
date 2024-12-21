import 'package:flutter/material.dart';

class IconWithBackground extends StatelessWidget {

  final Color backgroundColor;
  final double radius;

  final Widget child;
  IconWithBackground({required this.child,required this.backgroundColor,required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
     // elevation: 2.0,
      backgroundColor: backgroundColor,
      child: child,
      radius: radius,
    );
  }
}

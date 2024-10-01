import 'package:flutter/material.dart';

class FloatingActionWidget extends StatelessWidget {
  final Function onTap;

  final IconData icon;
  final Color? backgroundColor;

  const FloatingActionWidget({
    super.key,
    required this.onTap,
    required this.icon,
    this.backgroundColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        onTap();
      },
      backgroundColor: backgroundColor,
      elevation: 6,
      child: Icon(
        icon,
        size: 25,
        color: Colors.white,
      ), // Elevation to give shadow effect
    );
  }
}

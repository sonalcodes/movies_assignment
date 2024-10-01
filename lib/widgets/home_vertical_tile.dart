import 'package:flutter/material.dart';

class HomeVerticalTile extends StatelessWidget {
  final String? showName;

  final Function onTap;

  const HomeVerticalTile(
      {super.key, required this.showName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.grey.shade700,
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          showName ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
    ;
  }
}

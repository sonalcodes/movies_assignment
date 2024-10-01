import 'package:flutter/material.dart';

class TvShowDetailsBottomSheet {
  static void showTvDetailsBottomSheet({
    required BuildContext context,
    required String image,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Container(
            width: double.infinity, // Card-like width for each item
            margin: const EdgeInsets.all(4.0),
            child: Image.network(
              image,
              width: double.infinity,
            //  fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

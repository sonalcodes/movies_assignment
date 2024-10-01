import 'package:flutter/material.dart';

class HomeHorizontalTile extends StatelessWidget {
  final String? showImage;

  final Function onTap;
  final double? height;

  final double? width;

  const HomeHorizontalTile(
      {super.key,
      required this.showImage,
      required this.onTap,
      this.height = 200,
      this.width = 150});

  @override
  Widget build(BuildContext context) {
    return (showImage != null || (showImage?.isNotEmpty ?? false))
        ? GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              width: width, // Card-like width for each item
              margin: const EdgeInsets.all(4.0),
              child: Image.network(
                showImage ?? '',
                width: width,
                height: height,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          )
        : Container(
            width: 160,
            margin: const EdgeInsets.all(4.0),
            height: 200,
            child: const Center(
              child: Icon(
                Icons.person_outline_sharp,
              ),
            ),
          );
  }
}

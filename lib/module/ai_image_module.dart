import 'package:flutter/material.dart';

class ImageTextBottomSheet extends StatelessWidget {
  final ImageProvider image;
  final String text;

  const ImageTextBottomSheet({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            image: image,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          Text(
            text,
            // style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Usage example:
// showModalBottomSheet(
//   context: context,
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//   ),
//   builder: (context) => ImageTextBottomSheet(
//     image: NetworkImage('https://example.com/image.jpg'),
//     text: 'This is a sample text.',
//   ),
// );
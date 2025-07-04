import 'package:flutter/material.dart';

class CustomBookDetailsAppBar extends StatelessWidget {
  const CustomBookDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }
}

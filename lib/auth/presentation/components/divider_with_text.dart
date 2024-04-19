import 'package:flutter/material.dart';
import 'package:kakas/shared/resources/color_manager.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.black,
            height: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorManager.blue),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.black,
            height: 50,
          ),
        ),
      ],
    );
  }
}

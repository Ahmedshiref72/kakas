import 'package:flutter/material.dart';
import 'package:kakas/shared/resources/assets_manager.dart';

class SignWithOther extends StatelessWidget {
  const SignWithOther({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ImageBox(imagePath: ImageAssets.google),
        ImageBox(imagePath: ImageAssets.facebook),
        ImageBox(imagePath: ImageAssets.apple),


      ],
    );
  }
}

class ImageBox extends StatelessWidget {
  final String imagePath;

  const ImageBox({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}


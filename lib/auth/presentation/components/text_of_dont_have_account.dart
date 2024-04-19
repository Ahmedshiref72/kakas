import 'package:flutter/material.dart';
import 'package:kakas/shared/resources/app_strings.dart';
import 'package:kakas/shared/resources/color_manager.dart';

class TextOfDontHaveAccount extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const TextOfDontHaveAccount({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.dontHaveAccount,),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorManager.darkBlue),
          ),
        ),

      ],
    );
  }
}

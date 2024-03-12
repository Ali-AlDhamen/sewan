import 'package:flutter/material.dart';
import 'package:sewan/core/constants/app_sizes.dart';
import 'package:sewan/theme/app_colors.dart';


class WelcomeSignupMessage extends StatelessWidget {
  const WelcomeSignupMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        gapH64,
        Text(
          "Create Account!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.light.primary,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Fill Your Details Or Continue With Google",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.light.secondary
          ),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

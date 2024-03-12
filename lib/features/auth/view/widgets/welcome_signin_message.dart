import 'package:flutter/material.dart';
import 'package:sewan/core/constants/app_sizes.dart';
import 'package:sewan/theme/app_colors.dart';

class WelcomeSignInMessage extends StatelessWidget {
  const WelcomeSignInMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        gapH64,
        Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.light.primary,
          ),
        ),
        gapH12,
        Text(
          "please sign in to your account",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.light.secondary,
          ),
        ),
        gapH64,
      ],
    );
  }
}

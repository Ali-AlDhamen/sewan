import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/theme/app_colors.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({super.key});

  void navigateToSignupPage(BuildContext context) {
    context.go("/signup");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text("Don't have an account?",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.light.primary,
            )),
        TextButton(
          onPressed: () => navigateToSignupPage(context),
          child:  Text(
            "Sign Up",
            style: TextStyle(
              color: AppColors.light.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

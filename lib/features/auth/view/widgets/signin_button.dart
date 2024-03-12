import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/theme/app_colors.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({
    super.key,
  });

  void navigateToSigninPage(BuildContext context) {
    context.go("/signin");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Have an Account?",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.light.primary,
          ),
        ),
        TextButton(
          onPressed: () => navigateToSigninPage(context),
          child: Text(
            "Sign In",
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

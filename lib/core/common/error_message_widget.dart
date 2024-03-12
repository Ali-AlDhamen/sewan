import 'package:flutter/material.dart';
import 'package:sewan/theme/app_colors.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(this.errorMessage, {super.key});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: AppColors.light.primary),
    );
  }
}

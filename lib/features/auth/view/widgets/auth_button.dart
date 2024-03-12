import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sewan/core/common/loader_widget.dart';
import 'package:sewan/core/constants/app_sizes.dart';
import 'package:sewan/core/utils/async_value_ui.dart';
import 'package:sewan/theme/app_colors.dart';

import '../../controller/auth_controller.dart';

class AuthButton extends ConsumerWidget {
  final void Function() onPressed;
  final String text;
  const AuthButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(authControllerProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.light.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: state.isLoading ? null : () => onPressed(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: AppColors.light.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            gapW8,
            if (state.isLoading) LoaderWidget(color: AppColors.light.white),
          ],
        ),
      ),
    );
  }
}

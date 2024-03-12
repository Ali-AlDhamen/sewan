import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sewan/theme/app_colors.dart';
import '../constants/app_sizes.dart';

class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            gapH32,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.light.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton(
                onPressed: () => context.go("/home"),
                child:  Text(
                  "Go Home",
                  style: TextStyle(
                    color: AppColors.light.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

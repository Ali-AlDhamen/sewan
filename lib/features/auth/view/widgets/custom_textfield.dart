import 'package:flutter/material.dart';
import 'package:sewan/theme/app_colors.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
    required this.keyboardType,
    this.extra,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String? extra;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        cursorColor: AppColors.light.primary,
        scrollPadding: const EdgeInsets.only(bottom: 100),
        controller: controller,
        keyboardType: keyboardType,
        maxLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
              color: AppColors.light.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:  BorderSide(
              color: AppColors.light.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),

          hintStyle:  TextStyle(
            color: AppColors.light.primary,
            fontSize: 16,
          ),
          suffixText: extra, // Set the suffix text
          suffixStyle:  TextStyle(
            color: AppColors.light.primary,
            fontSize: 16,
          ),
        ),
        validator: validator,
      ),
    );
  }
}

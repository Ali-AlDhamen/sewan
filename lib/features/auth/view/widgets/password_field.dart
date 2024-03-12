import 'package:flutter/material.dart';
import 'package:sewan/theme/app_colors.dart';

import '../../../../core/utils/password_vaildator.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const PasswordField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible = false;

  void togglePasswordIcon() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

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
        keyboardType: TextInputType.visiblePassword,
        scrollPadding: const EdgeInsets.only(bottom: 100),
        obscureText: !_passwordVisible,
        controller: widget.controller,
        decoration: InputDecoration(
          hintStyle:  TextStyle(
            color: AppColors.light.primary,
            fontSize: 14,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.light.primary,
            ),
            onPressed: togglePasswordIcon,
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
          hintText: "Password",
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
        ),
        validator: passwordValidator,
      ),
    );
  }
}

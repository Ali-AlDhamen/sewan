import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sewan/core/constants/assets_constants.dart';
import 'package:sewan/theme/app_colors.dart';

FToast fToast = FToast();

enum ToastType {
  success,
  error,
}

showToast({
  required String message,
  required BuildContext context,
  required ToastType type,
}) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: AppColors.light.white,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          type == ToastType.error
              ? AssetsConstants.toastFailIcon
              : AssetsConstants.toastSuccessIcon,
          height: 20.h,
          width: 20.w,
        ),
        const SizedBox(
          width: 12.0,
        ),
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            message,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.light.black,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 2),
  );
}

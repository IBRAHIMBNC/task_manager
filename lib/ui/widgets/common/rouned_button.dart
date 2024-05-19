import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_corner/smooth_corner.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/widgets/common/custom_text.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
    this.label, {
    super.key,
    this.onTap,
    this.fontSize = 14,
    this.backgroundColor,
    this.fontColor,
    this.radius = 15,
    this.fontWeight,
    this.borderSide,
    this.isLoading = false,
    this.isFilled = true,
  });

  final String label;
  final Function()? onTap;
  final bool isLoading;
  final bool isFilled;
  final int fontSize;
  final Color? backgroundColor;
  final Color? fontColor;
  final double radius;
  final FontWeight? fontWeight;
  final BorderSide? borderSide;

  @override
  Widget build(BuildContext context) {
    return isFilled
        ? _buildFilledButton(context)
        : _buildOutlinedButton(context);
  }

  ElevatedButton _buildFilledButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: backgroundColor ?? AppColors.brandColor,
        disabledBackgroundColor: backgroundColor ?? AppColors.textColor2,
        maximumSize: Size(1.sw, 56.h),
        fixedSize: Size(0.92.sw, 50.h),
        shape: SmoothRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          smoothness: 1,
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (label.trim().isNotEmpty)
            CustomText(
              !isLoading ? label : 'Loading...',
              color: fontColor ?? Colors.white,
              size: fontSize,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
        ],
      ),
    );
  }

  OutlinedButton _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          side: borderSide ?? const BorderSide(color: AppColors.brandColor),
          maximumSize: Size(1.sw, 56.h),
          fixedSize: Size(0.92.sw, 49.h),
          shape: SmoothRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              smoothness: 1,
              side: borderSide ??
                  BorderSide(color: Theme.of(context).primaryColor)),
        ),
        onPressed: isLoading ? null : onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (label.trim().isNotEmpty)
              CustomText(
                !isLoading ? label : 'Loading...',
                color: fontColor ?? Theme.of(context).primaryColor,
                size: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
              ),
          ],
        ));
  }
}

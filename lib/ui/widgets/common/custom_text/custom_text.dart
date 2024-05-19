import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/ui/common/app_colors.dart';
/* import 'package:google_fonts/google_fonts.dart'; */

class CustomText extends StatelessWidget {
  final Color? color;
  final String text;
  final double height;
  final int size;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  final TextStyle? style;
  final int? maxLines;
  final TextDecoration? decoration;
  final bool autoSized;
  final double? minSize;
  final double? maxSize;

  const CustomText(this.text,
      {super.key,
      this.color,
      this.size = 12,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center,
      this.height = 1,
      this.overflow = TextOverflow.visible,
      this.style,
      this.maxLines,
      this.decoration,
      this.autoSized = false,
      this.minSize,
      this.maxSize});

  factory CustomText.massiveBold(String title,
      {int? size, Color? color, TextAlign? textAlign}) {
    return CustomText(
      title,
      size: size ?? 32,
      color: color ?? AppColors.textColor1,
      textAlign: textAlign ?? TextAlign.start,
      fontWeight: FontWeight.bold,
    );
  }

  factory CustomText.bigBold(String title,
      {int? size, Color? color, TextAlign? textAlign, FontWeight? fontWeight}) {
    return CustomText(
      title,
      size: size ?? 24,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: 1.4,
    );
  }

  factory CustomText.medBold(String title,
      {int? size, Color? color, TextAlign? textAlign}) {
    return CustomText(
      title,
      size: size ?? 20,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      fontWeight: FontWeight.w600,
      height: 1.4,
    );
  }

  factory CustomText.smallBold(
    String title, {
    int? size,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) {
    return CustomText(
      title,
      size: size ?? 16,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      fontWeight: FontWeight.w500,
      height: 1.4,
      maxLines: maxLines,
    );
  }

  factory CustomText.boldPara(
    String title, {
    int? size,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
  }) {
    return CustomText(
      title,
      size: size ?? 14,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: 1.4,
    );
  }

  factory CustomText.paragraph(String title,
      {int? size, Color? color, TextAlign? textAlign}) {
    return CustomText(
      title,
      size: size ?? 14,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      height: 1.4,
    );
  }

  factory CustomText.small(
    String title, {
    int? size,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    int? maxLines,
  }) {
    return CustomText(
      title,
      size: size ?? 12,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      height: 1.4,
      fontWeight: fontWeight ?? FontWeight.normal,
      maxLines: maxLines,
    );
  }

  factory CustomText.smaller(String title,
      {int? size, Color? color, TextAlign? textAlign}) {
    return CustomText(
      title,
      size: size ?? 10,
      color: color,
      textAlign: textAlign ?? TextAlign.start,
      height: 1.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    const defaultColor = AppColors.textColor1;
    return AutoSizeText(
      text,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
      minFontSize: minSize ?? style?.fontSize!.round().toDouble() ?? 4,
      maxFontSize: maxSize ?? double.infinity,
      style: style ??
          GoogleFonts.poppins(
            color: color ?? defaultColor,
            fontSize: size.sp,
            fontWeight: fontWeight,
            height: height,
            decoration: decoration,
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';

class CustomTextField extends StatefulWidget {
  final String hinText;
  final Color? bgColor;
  final bool isPassword;
  final double? borderRadius;
  final String? Function(String?)? validator;
  final Function(String? val)? onSave;
  final bool readOnly;
  final TextEditingController? controller;
  final bool obscureText;
  final Function(String? value)? onChanged;
  final IconData? prefixIcon;
  final Function()? onTap;
  final Widget? suffixWidget;
  final Color? borderColor;
  final Function(String)? onFieldSubmitted;
  final double? verticalPadding;

  const CustomTextField({
    super.key,
    required this.hinText,
    this.isPassword = false,
    this.onSave,
    this.validator,
    this.bgColor,
    this.borderRadius = 15,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixWidget,
    this.onFieldSubmitted,
    this.verticalPadding,
    this.borderColor,
  });

  @override
  State<CustomTextField> createState() => _NewTextFieldState();
}

class _NewTextFieldState extends State<CustomTextField> {
  late bool isVisible;
  bool showErrorMessage = false;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    isVisible = widget.isPassword;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        focusNode: _focusNode,
        onTap: widget.onTap,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        obscureText: isVisible,
        readOnly: widget.readOnly,
        style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontWeight: FontWeight.w400),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        validator: widget.validator,
        onSaved: widget.onSave,
        cursorColor: AppColors.textColor2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: kPadding24.w,
            vertical: widget.verticalPadding ?? 16.h,
          ),
          filled: true,
          fillColor: widget.bgColor ?? AppColors.pureWhite,
          hintStyle:
              GoogleFonts.poppins(fontSize: 14.sp, color: AppColors.textColor2),
          hintText: widget.hinText,
          errorStyle: GoogleFonts.poppins(fontSize: 12.sp),
          floatingLabelStyle:
              GoogleFonts.poppins(fontSize: 15.sp, color: AppColors.greyColor),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: Colors.red)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: BorderSide(
                  color: widget.borderColor ??
                      AppColors.brandColor.withOpacity(0.1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius!),
              borderSide: const BorderSide(color: AppColors.brandColor)),
          prefixIcon: Visibility(
            visible: widget.prefixIcon != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: kPadding12),
              child: Icon(
                widget.prefixIcon,
                color: _isFocused ? AppColors.brandColor : AppColors.textColor2,
                size: 24.sp,
              ),
            ),
          ),
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      !isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: _isFocused
                          ? AppColors.brandColor
                          : AppColors.textColor2,
                      size: 22.sp,
                    ),
                  ),
                )
              : widget.suffixWidget,
        ));
  }
}

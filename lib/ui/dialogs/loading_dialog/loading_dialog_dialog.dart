import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/ui/widgets/common/custom_text/custom_text.dart';

const double _graphicSize = 60;

class LoadingDialogDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const LoadingDialogDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 75.w),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(AppColors.brandColor),
            ),
            spacing12,
            CustomText.small(
              'Please wait...',
            ),
          ],
        ),
      ),
    );
  }
}

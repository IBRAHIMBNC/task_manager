import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:task_manager/ui/widgets/common/custom_text.dart';
import 'package:task_manager/ui/widgets/common/rouned_button.dart';

import 'info_alert_dialog_model.dart';

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kPadding20.w, vertical: kPadding20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText.medBold('Logout'),
            spacing8,
            CustomText.paragraph(
              'Are you sure you want to logout?',
              color: AppColors.textColor2,
            ),
            spacing16,
            Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    'No',
                    isFilled: false,
                    onTap: () {
                      completer(DialogResponse(confirmed: false));
                    },
                  ),
                ),
                spacing8,
                Expanded(
                  child: RoundedButton(
                    'Yes',
                    onTap: () {
                      completer(DialogResponse(confirmed: true));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}

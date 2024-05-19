import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.dialogs.dart';
import 'package:task_manager/app/app.locator.dart';

const double kPadding4 = 4;
const double kPadding8 = 8;
const double kPadding12 = 12;
const double kPadding16 = 16;
const double kPadding20 = 20;
const double kPadding24 = 24;
const double kPadding28 = 28;
const double kPadding32 = 32;
const double kPadding36 = 36;
const double kPadding40 = 40;

Widget spacing4 = Gap(kPadding4.sp);
Widget spacing8 = Gap(kPadding8.sp);
Widget spacing12 = Gap(kPadding12.sp);
Widget spacing16 = Gap(kPadding16.sp);
Widget spacing20 = Gap(kPadding20.sp);
Widget spacing24 = Gap(kPadding24.sp);
Widget spacing28 = Gap(kPadding28.sp);
Widget spacing32 = Gap(kPadding32.sp);
Widget spacing36 = Gap(kPadding36.sp);
Widget spacing40 = Gap(kPadding40.sp);

loading(bool isLoading) {
  if (!isLoading) {
    locator<DialogService>().completeDialog(DialogResponse(confirmed: true));
    return;
  }
  locator<DialogService>().showCustomDialog(
    variant: DialogType.loadingDialog,
    barrierDismissible: false,
  );
}

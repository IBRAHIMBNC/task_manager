import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/app/models/task.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/app_icons.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:task_manager/ui/widgets/common/custom_text/custom_text.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key, required this.task, this.onChanged, this.onDelete});
  final Todo task;
  final Function(bool?)? onChanged;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPadding8.w),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.brandColor.withOpacity(0.1),
          width: 1.w,
        ),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            visualDensity: VisualDensity.compact,
            value: task.isCompleted,
            onChanged: onChanged,
            checkColor: AppColors.pureWhite,
            fillColor: MaterialStateProperty.all(
                task.isCompleted ? AppColors.brandColor : AppColors.pureWhite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.r),
            ),
            side: BorderSide(
              color: AppColors.brandColor,
              width: 2.w,
            ),
          ),
        ),
        spacing8,
        Expanded(
          child: CustomText.smallBold(
            task.todo,
            color:
                task.isCompleted ? AppColors.brandColor : AppColors.textColor2,
            textAlign: TextAlign.start,
          ),
        ),
        spacing12,
        if (onDelete != null)
          InkWell(
            onTap: onDelete,
            child: SvgPicture.asset(
              AppIcons.delete,
              height: 20.sp,
              color: AppColors.brandColor,
            ),
          ),
        spacing8,
      ]),
    );
  }
}

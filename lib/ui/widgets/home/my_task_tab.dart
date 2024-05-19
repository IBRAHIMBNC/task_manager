import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:task_manager/ui/views/home/home_viewmodel.dart';
import 'package:task_manager/ui/widgets/common/custom_text.dart';
import 'package:task_manager/ui/widgets/home/task_card.dart';

class MyTasksTab extends StatelessWidget {
  const MyTasksTab({super.key, required this.viewModel});
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    if (viewModel.myTasks.isEmpty) {
      return Center(
        child: CustomText.smallBold('No Task added yet!',
            color: AppColors.textColor2),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kPadding20.w, vertical: kPadding16.h),
      child: ListView.separated(
        itemBuilder: (context, index) => TaskCard(
          task: viewModel.myTasks[index],
          onChanged: (value) {
            viewModel.toggleTaskStatus(viewModel.myTasks[index], value!);
          },
          onDelete: () {
            viewModel.removeTask(viewModel.myTasks[index].id);
          },
        ),
        separatorBuilder: (context, index) => spacing12,
        itemCount: viewModel.myTasks.length,
      ),
    );
  }
}

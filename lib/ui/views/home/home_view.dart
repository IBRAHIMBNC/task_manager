import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/app_strings.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:task_manager/ui/widgets/common/custom_text.dart';
import 'package:task_manager/ui/widgets/common/custom_textField.dart';
import 'package:task_manager/ui/widgets/home/my_task_tab.dart';
import 'package:task_manager/ui/widgets/home/paginated_task_tab.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(viewModel),
        body: TabBarView(children: [
          PaginatedTaskTab(viewModel: viewModel),
          MyTasksTab(viewModel: viewModel),
        ]),
        bottomSheet: Visibility(
          visible: viewModel.currentTabIndex == 1,
          child: Padding(
            padding: EdgeInsets.all(kPadding12.sp),
            child: CustomTextField(
                controller: viewModel.taskController,
                hinText: kAddTaskHintText,
                prefixIcon: Icons.task,
                suffixWidget: Visibility(
                  visible: viewModel.taskController.text.isNotEmpty,
                  child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        viewModel.addTask();
                      },
                      child: Icon(
                        CupertinoIcons.check_mark,
                        color: AppColors.brandColor,
                        size: 25.sp,
                      )),
                )),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(HomeViewModel viewModel) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: CustomText.medBold('TODO List'),
        actions: [
          CustomText.paragraph(
              '${viewModel.user.firstName} ${viewModel.user.lastName}'),
          spacing12,
          InkWell(
            onTap: viewModel.goToProfileScreen,
            child: CircleAvatar(
              radius: 22.r,
              backgroundColor: AppColors.brandColor,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.pureWhite,
                backgroundImage: NetworkImage(
                  viewModel.user.image,
                ),
              ),
            ),
          ),
          spacing20,
        ],
        bottom: TabBar(
          onTap: (value) {
            viewModel.setCurrentTabIndex = value;
          },
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(horizontal: kPadding24.w),
          unselectedLabelColor: AppColors.textColor2,
          tabs: const [
            Tab(
              text: 'Paginated ',
            ),
            Tab(
              text: 'My Tasks',
            ),
          ],
        ));
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}

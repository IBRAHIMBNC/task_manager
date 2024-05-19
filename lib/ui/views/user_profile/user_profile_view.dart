import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:task_manager/ui/widgets/common/custom_text.dart';
import 'package:task_manager/ui/widgets/common/custom_textField.dart';

import 'user_profile_viewmodel.dart';

class UserProfileView extends StackedView<UserProfileViewModel> {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UserProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(viewModel),
      body: Container(
        color: AppColors.pureWhite,
        child: Column(children: [
          Align(
            heightFactor: 0.6,
            child: Container(
              height: 250.h,
              width: double.infinity,
              color: AppColors.brandColor,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kPadding20.w,
                vertical: kPadding16.h,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(50.r),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 53.r,
                        backgroundColor: AppColors.brandColor,
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundColor: AppColors.pureWhite,
                          backgroundImage: NetworkImage(viewModel.user.image),
                        ),
                      ),
                    ),
                    spacing16,
                    Align(
                      alignment: Alignment.center,
                      child: CustomText.medBold(
                        '${viewModel.user.firstName} ${viewModel.user.lastName}',
                        size: 20,
                        color: AppColors.brandColor,
                      ),
                    ),
                    spacing16,
                    CustomText.smallBold('Username',
                        color: AppColors.brandColor),
                    spacing8,
                    CustomTextField(
                      hinText: '',
                      controller: viewModel.usernameController,
                      prefixIcon: CupertinoIcons.person_fill,
                      readOnly: true,
                    ),
                    spacing8,
                    CustomText.smallBold('Email', color: AppColors.brandColor),
                    spacing8,
                    CustomTextField(
                      hinText: '',
                      controller: viewModel.emailController,
                      prefixIcon: CupertinoIcons.envelope_fill,
                      readOnly: true,
                    ),
                    spacing8,
                    CustomText.smallBold('Gender', color: AppColors.brandColor),
                    spacing8,
                    CustomTextField(
                      hinText: '',
                      controller: viewModel.genderController,
                      prefixIcon: CupertinoIcons.person_2_fill,
                      readOnly: true,
                    ),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }

  AppBar _buildAppBar(UserProfileViewModel viewModel) {
    return AppBar(
      title: Row(
        children: [
          InkWell(
            onTap: () {
              locator<NavigationService>().back();
            },
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                border: Border.all(
                  color: AppColors.pureWhite,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.brandColor,
                size: 20.sp,
              ),
            ),
          ),
          spacing12,
          CustomText.medBold(
            'My Profile',
            color: AppColors.pureWhite,
          ),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: [
        InkWell(
          onTap: viewModel.logout,
          child: Row(
            children: [
              CustomText.smallBold(
                'Logout',
                color: AppColors.pureWhite,
                size: 14,
              ),
              spacing12,
              Icon(Icons.logout, color: AppColors.pureWhite, size: 22.sp),
            ],
          ),
        ),
        spacing20,
      ],
    );
  }

  @override
  UserProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UserProfileViewModel();
}

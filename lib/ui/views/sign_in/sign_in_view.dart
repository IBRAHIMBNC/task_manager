import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/app_icons.dart';
import 'package:task_manager/ui/common/app_strings.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';
import 'package:task_manager/ui/views/sign_in/sign_in_viewmodel.dart';
import 'package:task_manager/ui/widgets/common/custom_text/custom_text.dart';
import 'package:task_manager/ui/widgets/common/custom_textField.dart';
import 'package:task_manager/ui/widgets/common/rouned_button.dart';

class SignInView extends StackedView<SignInViewModel> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignInViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kPadding20.w, vertical: kPadding40.h),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.logo,
                  height: 110.h,
                ),
                spacing8,
                CustomText.bigBold(
                  kLoginPageTitle,
                  size: 18,
                  color: AppColors.textColor2,
                  fontWeight: FontWeight.w500,
                ),
                spacing4,
                CustomText.smallBold(
                  kLoginPageSubtitle,
                  size: 14,
                ),
                spacing32,
                CustomTextField(
                  prefixIcon: CupertinoIcons.person_fill,
                  hinText: kUsernameHintText,
                  onSave: (value) {
                    viewModel.username = value!.trim();
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                spacing20,
                CustomTextField(
                  prefixIcon: CupertinoIcons.lock_fill,
                  hinText: kPasswordHintText,
                  isPassword: true,
                  onSave: (value) {
                    viewModel.password = value!.trim();
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                spacing40,
                RoundedButton(
                  kLoginButtonText,
                  onTap: viewModel.login,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  SignInViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignInViewModel();
}

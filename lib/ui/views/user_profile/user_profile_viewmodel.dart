import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.dialogs.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/app/models/app_user.dart';
import 'package:task_manager/services/auth_service.dart';

class UserProfileViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();

  AppUser get user => _authService.appUser!;

  UserProfileViewModel() {
    init();
  }

  init() {
    usernameController.text = user.username;
    emailController.text = user.email;
    genderController.text = user.gender.name;
  }

  logout() async {
    final dialogResponse = await _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      barrierDismissible: false,
    );
    if (dialogResponse!.confirmed) {
      await _authService.logout();
      _navigationService.clearStackAndShow(Routes.signInView);
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    genderController.dispose();

    super.dispose();
  }
}

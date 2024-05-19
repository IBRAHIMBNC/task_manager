import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:task_manager/app/app.snackbars.dart';
import 'package:task_manager/app/enums/auth_response.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';

class SignInViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final _authService = locator<AuthService>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  String username = '';
  String password = '';

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      debugPrint('username: $username');
      debugPrint('password: $password');
      loading(true);
      final result = await _authService.login(username, password);
      if (result == AuthResponse.success) {
        loading(false);
        _navigationService.replaceWithHomeView();
      } else {
        loading(false);
        await _snackbarService.closeSnackbar();
        _snackbarService.showCustomSnackBar(
          message: result.message,
          variant: SnackbarType.error,
        );
      }
    }
  }
}

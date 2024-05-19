import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.locator.dart';

enum SnackbarType {
  defaultBar,
  error,
  success,
}

void setupSnackbarUi() {
  final service = locator<SnackbarService>();

  // Registers a config to be used when calling showSnackbar
  service.registerSnackbarConfig(SnackbarConfig(
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
  ));

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.defaultBar,
    config: SnackbarConfig(
      backgroundColor: Colors.black,
      textColor: Colors.white,
      borderRadius: 1,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      borderRadius: 1,
      messageTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      messageTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.green,
      textColor: Colors.white,
      borderRadius: 1,
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:stacked_services/stacked_services.dart';

void setupSnackbarUi() {
  final service = getIt<SnackbarService>();

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.error,
    config: SnackbarConfig(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      borderRadius: 1,
      dismissDirection: DismissDirection.vertical,
      snackPosition: SnackPosition.TOP,
    ),
  );

  service.registerCustomSnackbarConfig(
    variant: SnackbarType.success,
    config: SnackbarConfig(
      backgroundColor: Colors.green,
      textColor: Colors.white,
      borderRadius: 1,
      dismissDirection: DismissDirection.vertical,
      snackPosition: SnackPosition.TOP,
    ),
  );
}

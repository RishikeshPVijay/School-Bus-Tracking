import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:smart_school_bus/utils/is_email_valid.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  final GlobalKey<FormState> loginFormKey = GlobalKey();

  String email = '', password = '';

  bool Function(String) isValidEmailFn = isValidEmail;

  Future<void> gotoSignUpView() async {
    await navigateAndReplace(Routes.signUpView);
  }

  Future<void> navigateAndReplace(String routeName) async {
    await _navigationService.replaceWith(routeName);
  }

  void login() async {
    try {
      if (!loginFormKey.currentState!.validate()) return;
      loginFormKey.currentState!.save();
      await _authenticationService.login(email.trim(), password.trim());
      _navigationService.clearStackAndShow(Routes.homeView);
    } catch (err) {
      _snackbarService.showCustomSnackBar(
        message: err.toString().split(']').last,
        variant: SnackbarType.error,
        duration: const Duration(seconds: 5),
      );
    }
  }
}

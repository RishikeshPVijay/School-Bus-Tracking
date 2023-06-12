import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:smart_school_bus/utils/is_email_valid.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();

  final GlobalKey<FormState> signupFormKey = GlobalKey();
  String name = '', email = '', password = '';
  UserType? userType;

  void setUserType(UserType? userType) {
    this.userType = userType;
  }

  bool Function(String) isValidEmailFn = isValidEmail;

  bool isNameValid(String name) => name.split(' ').length > 1;

  bool isSigningUp = false;

  Future<void> gotoLoginView() async {
    await _navigationService.replaceWith(Routes.loginView);
  }

  void signup() async {
    try {
      if (!signupFormKey.currentState!.validate()) return;
      isSigningUp = true;
      notifyListeners();

      signupFormKey.currentState!.save();
      final UserCredential authRes =
          await _authenticationService.signup(email.trim(), password.trim());
      await FirebaseFirestore.instance
          .collection(FireStoreCollections.users)
          .doc(authRes.user!.uid)
          .set({
        'id': authRes.user!.uid,
        'name': name,
        'email': email,
        'user_type': userType!.toShortString(),
      });
      _navigationService.clearStackAndShow(Routes.homeView);
    } catch (err) {
      isSigningUp = false;
      notifyListeners();
      _snackbarService.showCustomSnackBar(
        message: err.toString().split(']').last,
        variant: SnackbarType.error,
        duration: const Duration(seconds: 5),
      );
    }
  }
}

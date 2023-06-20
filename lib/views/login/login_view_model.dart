import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
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
  bool isLogginIn = false;

  bool Function(String) isValidEmailFn = isValidEmail;

  Future<void> gotoSignUpView() async {
    await navigateAndReplace(Routes.signUpView);
  }

  Future<void> navigateAndReplace(String routeName) async {
    await _navigationService.replaceWith(routeName);
  }

  void handleFCMToken(String fcmToken, User? user) {
    if (user == null) return;
    FirebaseFirestore.instance
        .collection(FireStoreCollections.users)
        .doc(user.uid)
        .update({'token': fcmToken});
  }

  void login() async {
    try {
      if (!loginFormKey.currentState!.validate()) return;
      isLogginIn = true;
      notifyListeners();
      loginFormKey.currentState!.save();
      await _authenticationService.login(email.trim(), password.trim());

      final fcm = FirebaseMessaging.instance;
      final User? user = _authenticationService.getUser();
      final fcmToken = await fcm.getToken();
      if (fcmToken != null) handleFCMToken(fcmToken, user);
      fcm.onTokenRefresh.listen((fcmToken) {
        handleFCMToken(fcmToken, user);
      }).onError((err) {
        // Error getting token.
      });

      _navigationService.clearStackAndShow(Routes.homeView);
    } catch (err) {
      isLogginIn = false;
      notifyListeners();
      _snackbarService.showCustomSnackBar(
        message: err.toString().split(']').last,
        variant: SnackbarType.error,
        duration: const Duration(seconds: 5),
      );
    }
  }
}

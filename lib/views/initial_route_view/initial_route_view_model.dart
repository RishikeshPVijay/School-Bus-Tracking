import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InitialRouteViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  void handleFCMToken(String fcmToken, User? user) {
    if (user == null) return;
    FirebaseFirestore.instance
        .collection(FireStoreCollections.users)
        .doc(user.uid)
        .update({'token': fcmToken});
  }

  Future handleStartUp() async {
    final isUserLoggedIn = await _authenticationService.isUserLoggedIn();
    if (isUserLoggedIn) {
      final fcm = FirebaseMessaging.instance;
      final User? user = _authenticationService.getUser();
      final fcmToken = await fcm.getToken();
      if (fcmToken != null) handleFCMToken(fcmToken, user);
      fcm.onTokenRefresh.listen((fcmToken) {
        handleFCMToken(fcmToken, user);
      }).onError((err) {
        // Error getting token.
      });
      _replaceView(Routes.homeView);
    } else {
      _replaceView(Routes.loginView);
    }
  }

  Future<void> _replaceView(String viewName) async {
    await _navigationService.clearStackAndShow(viewName);
  }
}

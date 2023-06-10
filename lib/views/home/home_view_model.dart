import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();

  bool isViewLoading = true;

  User? user = FirebaseAuth.instance.currentUser;
  var stream = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  void navigateToMapsView() => _navigate(Routes.mapView);

  Future<void> _navigate(String viewName) async {
    await _navigationService.navigateTo(viewName);
  }
}

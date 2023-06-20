import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/models/ssb_user.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final _firestore = FirebaseFirestore.instance;

  late final SSBUser user;

  bool isViewLoading = true;

  late Bus selectedBus;

  void logout() {
    _authenticationService.logout();
  }

  void navigateToMapsView(Bus bus) => _navigate(
        Routes.mapView,
        MapViewArguments(bus: bus),
      );
  void navigateToBusView() => _navigate(Routes.busView);
  void navigateToStudentView() => _navigate(Routes.studentView);

  Future<void> _navigate(String viewName, [dynamic arguments]) async {
    await _navigationService.navigateTo(viewName, arguments: arguments);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getBusDataStream() {
    switch (user.userType) {
      case UserType.admin:
        return _firestore.collection(FireStoreCollections.buses).snapshots();
      case UserType.parent:
        return _firestore
            .collection(FireStoreCollections.buses)
            .where('parents', arrayContains: user.id)
            .snapshots();
      default:
        return null;
    }
  }
}

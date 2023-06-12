import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/models/ssb_user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  late final SSBUser user;
  final _firestore = FirebaseFirestore.instance;

  void navigateToAddStudentView() {
    _navigationService.navigateTo(Routes.addStudentView);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getBusDataStream() {
    switch (user.userType) {
      case UserType.admin:
        return _firestore
            .collection(FireStoreCollections.students)
            .where('parent', isEqualTo: user.id)
            .snapshots();
      case UserType.parent:
        return _firestore
            .collection(FireStoreCollections.students)
            .where('parent', isEqualTo: user.id)
            .snapshots();
      default:
        return null;
    }
  }
}

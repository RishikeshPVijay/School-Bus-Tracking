import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/models/ssb_user.dart';
import 'package:smart_school_bus/models/student.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StudentViewModel extends BaseViewModel {
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final DialogService _dialogService = getIt<DialogService>();
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

  void handleStudentDelete(Student student) async {
    try {
      DialogResponse<dynamic>? dialogResponse = await _dialogService.showDialog(
          title: 'Delete this record?',
          buttonTitle: 'Delete',
          cancelTitle: 'Cancel');
      if (dialogResponse == null || !dialogResponse.confirmed) return;
      await _firestore
          .collection(FireStoreCollections.students)
          .doc(student.id)
          .delete();
    } catch (err) {
      _snackbarService.showCustomSnackBar(
        message: err.toString().split(']').last,
        variant: SnackbarType.error,
        duration: const Duration(seconds: 5),
      );
    }
  }
}

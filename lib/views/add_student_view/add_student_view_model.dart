import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddStudentViewModel extends BaseViewModel implements Initialisable {
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final _firestore = FirebaseFirestore.instance;

  List<Bus> busesList = [];
  bool isBusListFetching = true;

  @override
  void initialise() {
    _fetchBuses().then((buses) {
      busesList = buses!;
      isBusListFetching = false;
      notifyListeners();
    });
  }

  final GlobalKey<FormState> addStudentFormKey = GlobalKey();
  TextEditingController busSelectController = TextEditingController();
  String busId = '', name = '', cls = '', admissionNumber = '', address = '';
  bool isNewStudentAdding = false;

  Future<List<Bus>?> _fetchBuses() async {
    try {
      QuerySnapshot<Map<String, dynamic>> busesSnapshot =
          await _firestore.collection(FireStoreCollections.buses).get();
      return busesSnapshot.docs
          .map((document) => Bus.fromFirestore(document.data()))
          .toList();
    } catch (err) {
      showError(err);
      return null;
    }
  }

  bool isNameValid(String name) => name.split(' ').length > 1;

  void setSelectedBus(Bus bus) {
    busSelectController.text = '${bus.busNo}\n${bus.route}';
    busId = bus.id;
  }

  void addStudent() async {
    try {
      User? user = _authenticationService.getUser();
      if (!addStudentFormKey.currentState!.validate()) return;
      isNewStudentAdding = true;
      notifyListeners();

      addStudentFormKey.currentState!.save();

      var lastStudentDocMap = await _firestore
          .collection(FireStoreCollections.students)
          .orderBy('id', descending: true)
          .limit(1)
          .get();

      String id = lastStudentDocMap.docs.isNotEmpty
          ? '${int.parse(lastStudentDocMap.docs.last.id) + 1}'
          : '1';
      var newStudentDoc = await _firestore
          .collection(FireStoreCollections.students)
          .doc(id)
          .set({
        'id': id,
        'name': name,
        'class': cls,
        'admissionNumber': admissionNumber,
        'address': address,
        'busId': busId,
        'parent': user!.uid
      });

      await _firestore
          .collection(FireStoreCollections.buses)
          .doc(busId)
          .update({
        'parents': FieldValue.arrayUnion([user.uid])
      });

      isNewStudentAdding = false;
      notifyListeners();
    } catch (err) {
      isNewStudentAdding = false;
      notifyListeners();
      showError(err);
    }
    _navigationService.back();
  }

  void showError(Object err) {
    _snackbarService.showCustomSnackBar(
      message: err.toString().split(']').last,
      variant: SnackbarType.error,
      duration: const Duration(seconds: 5),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddStudentViewModel extends BaseViewModel {
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();
  final _firestore = FirebaseFirestore.instance;

  final GlobalKey<FormState> addStudentFormKey = GlobalKey();

  String busId = '', name = '', cls = '', admissionNumber = '', address = '';
  bool isNewStudentAdding = false;

  void addStudent() async {
    try {
      User? user = await _authenticationService.getUser();
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
      await _firestore.collection(FireStoreCollections.students).doc(id).set({
        'id': id,
        'class': cls,
        'admissionNumber': admissionNumber,
        'address': address,
        'parent': user!.uid
      });

      isNewStudentAdding = false;
      notifyListeners();
    } catch (err) {
      isNewStudentAdding = false;
      notifyListeners();
      _snackbarService.showCustomSnackBar(
        message: err.toString().split(']').last,
        variant: SnackbarType.error,
        duration: const Duration(seconds: 5),
      );
    }
    _navigationService.back();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/snackbar_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddBusViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final SnackbarService _snackbarService = getIt<SnackbarService>();
  final GlobalKey<FormState> addBusFormKey = GlobalKey();
  final _firestore = FirebaseFirestore.instance;

  String busNo = '', route = '', driver = '';

  bool isNewBusAdding = false;

  void addBus() async {
    try {
      if (!addBusFormKey.currentState!.validate()) return;
      isNewBusAdding = true;
      notifyListeners();

      addBusFormKey.currentState!.save();

      var lastBusDocMap = await _firestore
          .collection(FireStoreCollections.buses)
          .orderBy('id', descending: true)
          .limit(1)
          .get();

      String id = lastBusDocMap.docs.isNotEmpty
          ? '${int.parse(lastBusDocMap.docs.last.id) + 1}'
          : '1';
      await _firestore.collection(FireStoreCollections.buses).doc(id).set({
        'id': id,
        'busNo': busNo,
        'driver': driver,
        'route': route,
      });

      isNewBusAdding = false;
      notifyListeners();
    } catch (err) {
      isNewBusAdding = false;
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

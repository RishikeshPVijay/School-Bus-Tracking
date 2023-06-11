import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/models/ssb_user.dart';
import 'package:stacked/stacked.dart';

class BusViewModle extends BaseViewModel {
  late final SSBUser user;
  final _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>>? getDataStream() {
    switch (user.userType) {
      case UserType.admin:
        return _firestore.collection(FireStoreCollections.buses).snapshots();
      default:
        return null;
    }
  }
}

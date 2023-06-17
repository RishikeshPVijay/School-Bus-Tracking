import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/models/firestore_collections.dart';
import 'package:smart_school_bus/models/location.dart';
import 'package:stacked/stacked.dart';

class MapViewModel extends BaseViewModel {
  late GoogleMapController mapController;
  final _firestore = FirebaseFirestore.instance;
  late final Bus bus;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final double zoom = 17.0;

  void updateMarkerIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "images/bus.png",
    );
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBusLocationStream() {
    return _firestore
        .collection(FireStoreCollections.locations)
        .where('busId', isEqualTo: bus.id)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots();
  }

  void updatePosition(Location location) async {
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(location.lat, location.lng),
          zoom: zoom,
        ),
      ),
    );
  }
}

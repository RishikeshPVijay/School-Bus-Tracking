import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
  bool isMarkerIconSet = false;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void updateMarkerIcon() async {
    try {
      final Uint8List markerIconA =
          await getBytesFromAsset('images/map_marker.png', 100);

      markerIcon = BitmapDescriptor.fromBytes(markerIconA);
      notifyListeners();
    } catch (err) {
      // error handling
    }
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

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class MapViewModel extends BaseViewModel {
  late GoogleMapController mapController;

  void updatePosition() async {
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(11.83320423902614, 76.19573237628512),
          zoom: 15.0,
        ),
      ),
    );
  }
}

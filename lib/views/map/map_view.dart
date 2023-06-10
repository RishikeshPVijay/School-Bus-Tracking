import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page.dart';
import 'package:smart_school_bus/views/map/map_view_model.dart';
import 'package:stacked/stacked.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, model, child) {
        return SSBDashboardPage(
          isPadded: false,
          appBarTitle: 'Bus Location',
          body: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: GoogleMap(
              onMapCreated: (controller) {
                model.mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(45.521563, -122.677433),
                zoom: 11.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/map/map_view_model.dart';
import 'package:stacked/stacked.dart';

class MapView extends StatelessWidget {
  final Bus bus;
  const MapView({
    super.key,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, model, child) {
        return SSBDashboardPageWithUser(
          isPadded: false,
          appBarTitle: 'Bus Location',
          builder: (user) => ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: GoogleMap(
              onMapCreated: (controller) {
                model.mapController = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(11.986031607162392, 75.38164366749024),
                zoom: 15.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

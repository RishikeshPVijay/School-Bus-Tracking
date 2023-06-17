import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/models/location.dart';
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
      onViewModelReady: (viewModel) => viewModel.bus = bus,
      viewModelBuilder: () => MapViewModel(),
      builder: (context, viewModel, child) {
        return SSBDashboardPageWithUser(
          isPadded: false,
          appBarTitle: 'Bus Location',
          builder: (user) => StreamBuilder(
              stream: viewModel.getBusLocationStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }
                List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs =
                    snapshot.data?.docs;
                if (docs == null || docs.isEmpty) {
                  return const Center(
                    child: Text('No locations found'),
                  );
                }
                Location location = Location.fromFirestore(docs[0].data());
                viewModel.updatePosition(location);
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                  ),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      viewModel.mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(location.lat, location.lng),
                      zoom: viewModel.zoom,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("marker2"),
                        position: LatLng(location.lat, location.lng),
                        icon: viewModel.markerIcon,
                      ),
                    },
                  ),
                );
              }),
        );
      },
    );
  }
}

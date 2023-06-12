import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/bus_view/bus_view_model.dart';
import 'package:stacked/stacked.dart';

class BusView extends StatelessWidget {
  const BusView({super.key});

  @override
  Widget build(BuildContext context) {
    return SSBDashboardPageWithUser(
      appBarTitle: 'Bus',
      isPadded: false,
      builder: (user) {
        return ViewModelBuilder.reactive(
          onViewModelReady: (viewModel) => viewModel.user = user,
          viewModelBuilder: () => BusViewModel(),
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: viewModel.navigateToAddBusView,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, size: 20.0),
                      Text(
                        'Add bus',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                getTable(viewModel.getDataStream()),
              ],
            );
          },
        );
      },
    );
  }
}

Widget getTable(Stream<QuerySnapshot<Map<String, dynamic>>>? stream) {
  return StreamBuilder(
    stream: stream,
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
      var data = snapshot.data?.docs;
      if (data == null || data.isEmpty) {
        return Container();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Bus No')),
            DataColumn(label: Text('Driver')),
            DataColumn(label: Text('Route'))
          ],
          rows: data.map((doc) {
            Bus bus = Bus.fromFirestore(doc.data());
            return DataRow(
              cells: [
                DataCell(Text(bus.id)),
                DataCell(Text(bus.busNo)),
                DataCell(Text(bus.driver)),
                DataCell(Text(bus.route)),
              ],
            );
          }).toList(),
        ),
      );
    },
  );
}

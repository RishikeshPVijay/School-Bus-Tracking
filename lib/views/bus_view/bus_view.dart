import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/bus_view/bus_view_model.dart';
import 'package:stacked/stacked.dart';

class BusView extends StatelessWidget {
  const BusView({super.key, required this.userType});

  final UserType userType;

  @override
  Widget build(BuildContext context) {
    return SSBDashboardPageWithUser(
      appBarTitle: 'Bus',
      isPadded: false,
      builder: (user) {
        return ViewModelBuilder.reactive(
          onViewModelReady: (viewModel) => viewModel.user = user,
          viewModelBuilder: () => BusViewModle(),
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {},
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
      return DataTable(
        columns: const [
          DataColumn(label: Text('Bus ID')),
          DataColumn(label: Text('Driver name')),
          DataColumn(label: Text('Stops'))
        ],
        rows: const [
          DataRow(
            cells: [
              DataCell(Text('#100')),
              DataCell(Text('Flutter Basics')),
              DataCell(Text('David John'))
            ],
          ),
          DataRow(
            cells: [
              DataCell(Text('#101')),
              DataCell(Text('Dart Internals')),
              DataCell(Text('Alex Wick'))
            ],
          )
        ],
      );
    },
  );
}

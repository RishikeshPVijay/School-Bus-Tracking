import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/bus_view/bus_view_model.dart';
import 'package:stacked/stacked.dart';

class BusView extends StatelessWidget {
  const BusView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SSBDashboardPageWithUser(
      appBarTitle: 'Bus',
      isPadded: false,
      builder: (user) {
        final bool isAdmin = user.userType == UserType.admin;

        return ViewModelBuilder.reactive(
          onViewModelReady: (viewModel) => viewModel.user = user,
          viewModelBuilder: () => BusViewModel(),
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isAdmin)
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
                getTable(viewModel.getBusDataStream(), screenWidth, isAdmin),
              ],
            );
          },
        );
      },
    );
  }
}

Widget getTable(
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream,
  double screenWidth,
  bool isAdmin,
) {
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
      if (data == null) {
        return Container();
      }
      if (data.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(isAdmin
                ? 'No buses added'
                : 'No buses found with verified students added by you.'),
          ),
        );
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth),
          child: DataTable(
            columnSpacing: 5.0,
            columns: const [
              // if (isAdmin) const DataColumn(label: Text('ID')),
              DataColumn(label: Text('Bus No')),
              DataColumn(label: Text('Driver')),
              DataColumn(label: Text('Actions'))
            ],
            rows: data.map((doc) {
              Bus bus = Bus.fromFirestore(doc.data());
              return DataRow(
                cells: [
                  // if (isAdmin) DataCell(Text(bus.id)),
                  DataCell(Text(bus.busNo)),
                  DataCell(Text(bus.driver)),
                  DataCell(
                    Row(
                      children: [
                        // InkWell(
                        //   onTap: () {},
                        //   child: Icon(
                        //     Icons.delete,
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   width: 15.0,
                        // ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/student.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/student_view/student_view_model.dart';
import 'package:stacked/stacked.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SSBDashboardPageWithUser(
      appBarTitle: 'Student',
      isPadded: false,
      builder: (user) {
        final bool isParent = user.userType == UserType.parent;

        return ViewModelBuilder.reactive(
          onViewModelReady: (viewModel) => viewModel.user = user,
          viewModelBuilder: () => StudentViewModel(),
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isParent)
                  TextButton(
                    onPressed: viewModel.navigateToAddStudentView,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 20.0),
                        Text(
                          'Add Student',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                getTable(viewModel.getBusDataStream(), viewModel, screenWidth),
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
  StudentViewModel viewModel,
  double screenWidth,
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
      if (data == null || data.isEmpty) {
        return Container();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: screenWidth),
          child: DataTable(
            columnSpacing: 5.0,
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Verification')),
              DataColumn(label: Text('Action')),
            ],
            rows: data.map((doc) {
              Student student = Student.fromFirestore(doc.data());
              return DataRow(
                cells: [
                  DataCell(Text(student.name)),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: student.rfid != null
                          ? const Icon(
                              Icons.verified,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.pending,
                              color: Colors.redAccent,
                            ),
                    ),
                  ),
                  DataCell(
                    Row(
                      children: [
                        InkWell(
                          onTap: () => viewModel.handleStudentDelete(student),
                          child: Icon(
                            Icons.delete,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
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

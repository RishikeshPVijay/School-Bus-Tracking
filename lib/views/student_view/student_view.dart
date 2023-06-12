import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/models/student.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/student_view/student_view_model.dart';
import 'package:stacked/stacked.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SSBDashboardPageWithUser(
      appBarTitle: 'Student',
      builder: (user) {
        return ViewModelBuilder.reactive(
          onViewModelReady: (viewModel) => viewModel.user = user,
          viewModelBuilder: () => StudentViewModel(),
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                getTable(viewModel.getBusDataStream()),
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
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Class')),
            DataColumn(label: Text('Bus')),
            DataColumn(label: Text('Ad No')),
            DataColumn(label: Text('Address')),
          ],
          rows: data.map((doc) {
            Student student = Student.fromFirestore(doc.data());
            return DataRow(
              cells: [
                DataCell(Text(student.id)),
                DataCell(Text(student.name)),
                DataCell(Text(student.cls)),
                DataCell(Text(student.busId)),
                DataCell(Text(student.admissionNumber)),
                DataCell(Text(student.address)),
              ],
            );
          }).toList(),
        ),
      );
    },
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/student.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/student_view/student_view_model.dart';
import 'package:smart_school_bus/widgets/loader_button.dart';
import 'package:stacked/stacked.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                getTable(
                    viewModel.getStudentDataStream(), viewModel, screenSize),
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
  Size screenSize,
) {
  Widget getDataTable(List<QueryDocumentSnapshot<Map<String, dynamic>>> data,
      BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: screenSize.width),
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
                      if (student.rfid == null)
                        const SizedBox(
                          width: 15.0,
                        ),
                      if (student.rfid == null)
                        InkWell(
                          onTap: () {
                            showAddRFIDBottomSheet(
                              context,
                              student,
                              viewModel,
                            );
                          },
                          child: Icon(
                            Icons.edit,
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
  }

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
      final bool isAdmin = viewModel.user.userType == UserType.admin;
      if (data == null || data.isEmpty) {
        return const Center(
          child: Text('No students added'),
        );
      }
      if (isAdmin) {
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(
                height: 48,
                child: TabBar(
                  tabs: [
                    Tab(
                      child: Text('Not verified'),
                    ),
                    Tab(
                      child: Text('Verified'),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenSize.height -
                      48 -
                      (Scaffold.of(context).appBarMaxHeight ?? 0),
                ),
                child: TabBarView(
                  children: [
                    getDataTable(
                      data
                          .where((element) => element.data()['rfid'] == null)
                          .toList(),
                      context,
                    ),
                    getDataTable(
                      data
                          .where((element) => element.data()['rfid'] != null)
                          .toList(),
                      context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return getDataTable(data, context);
      }
    },
  );
}

void showAddRFIDBottomSheet(
  BuildContext context,
  Student student,
  StudentViewModel viewModel,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 250.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        child: Column(
          children: [
            Center(
              child: Text(student.name),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Expanded(
              child: TextField(
                controller: viewModel.rfidTextController,
                decoration: const InputDecoration(
                  hintText: 'RFID',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LoaderButton(
                  onPressed: () {
                    viewModel.handleAddRFID(student).then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                  trailingIcon: Icons.add,
                  loading: viewModel.isRFIDAdding,
                  text: 'Add RFID',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

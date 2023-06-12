import 'package:flutter/material.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page.dart';
import 'package:smart_school_bus/views/add_student_view/add_student_view_model.dart';
import 'package:smart_school_bus/widgets/loader_button.dart';
import 'package:stacked/stacked.dart';

class AddStudentView extends StatelessWidget {
  const AddStudentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SSBDashboardPage(
      appBarTitle: 'Add Student',
      body: ViewModelBuilder.reactive(
        viewModelBuilder: () => AddStudentViewModel(),
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Form(
              key: viewModel.addStudentFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    key: const ValueKey('name'),
                    onSaved: (value) {
                      viewModel.name = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: const ValueKey('Class'),
                    onSaved: (value) {
                      viewModel.cls = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Class',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: const ValueKey('admissionNumber'),
                    onSaved: (value) {
                      viewModel.admissionNumber = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Admission number',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: const ValueKey('address'),
                    onSaved: (value) {
                      viewModel.address = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Address',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: const ValueKey('busId'),
                    onSaved: (value) {
                      viewModel.address = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'bus',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LoaderButton(
                    onPressed: viewModel.addStudent,
                    loading: viewModel.isNewStudentAdding,
                    text: 'Add Student',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_school_bus/models/bus.dart';
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
                    validator: (value) {
                      if (value!.isEmpty || !viewModel.isNameValid(value)) {
                        return 'Name must have a first_name and last_name';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Class is required';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Admission number is required';
                      }
                      return null;
                    },
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: viewModel.busSelectController,
                    key: const ValueKey('busId'),
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'bus',
                    ),
                    onTap: () => showBusSelectModal(context, viewModel),
                    maxLines: 2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Select a bus';
                      }
                      return null;
                    },
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

void showBusSelectModal(BuildContext context, AddStudentViewModel viewModel) {
  Widget getChild() {
    if (viewModel.isBusListFetching) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Theme.of(context).primaryColor,
          ),
        ),
      );
    }
    List<Bus> busList = [...viewModel.busesList, ...viewModel.busesList];
    if (busList.isEmpty) {
      return const Center(
        child: Text('No buses to show'),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Select bus',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: viewModel.busesList.length,
            itemBuilder: (context, index) {
              Bus bus = viewModel.busesList[index];
              return InkWell(
                onTap: () {
                  viewModel.setSelectedBus(bus);
                  Navigator.of(context).pop();
                },
                child: Card(
                  elevation: 0,
                  color: viewModel.busId == bus.id
                      ? Theme.of(context).primaryColor.withOpacity(0.3)
                      : Colors.white,
                  child: ListTile(
                    title: Text(bus.busNo),
                    subtitle: Text(bus.route),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        width: double.infinity,
        height: double.infinity,
        child: getChild(),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page.dart';
import 'package:smart_school_bus/views/add_bus_view/add_bus_view_model.dart';
import 'package:smart_school_bus/widgets/loader_button.dart';
import 'package:stacked/stacked.dart';

class AddBusView extends StatelessWidget {
  const AddBusView({super.key});

  @override
  Widget build(BuildContext context) {
    return SSBDashboardPage(
      appBarTitle: 'Add Bus',
      // isPadded: false,
      body: ViewModelBuilder.reactive(
        viewModelBuilder: () => AddBusViewModel(),
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Form(
              key: viewModel.addBusFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    key: const ValueKey('busNo'),
                    onSaved: (value) {
                      viewModel.busNo = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Bus number',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: const ValueKey('driver'),
                    onSaved: (value) {
                      viewModel.driver = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Driver name',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    key: const ValueKey('route'),
                    onSaved: (value) {
                      viewModel.route = value!;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Route',
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  LoaderButton(
                    onPressed: viewModel.addBus,
                    loading: viewModel.isNewBusAdding,
                    text: 'Add bus',
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

import 'package:flutter/material.dart';
import 'package:smart_school_bus/pages/smb_dashboard_page.dart';
import 'package:smart_school_bus/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return const SMBDashboardPage(
          appBarTitle: 'SMB',
          body: Column(
            children: [
              Text('Hello there'),
            ],
          ),
        );
      },
    );
  }
}

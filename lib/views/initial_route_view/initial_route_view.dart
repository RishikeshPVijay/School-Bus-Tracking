import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import './initial_route_view_model.dart';

class InitialRouteView extends StatelessWidget {
  const InitialRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InitialRouteViewModel>.reactive(
      onViewModelReady: (model) => model.handleStartUp(),
      builder: (context, model, ch) => Scaffold(
        body: Container(),
      ),
      viewModelBuilder: () => InitialRouteViewModel(),
    );
  }
}

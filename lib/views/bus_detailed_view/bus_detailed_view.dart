import 'package:flutter/material.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page.dart';

class BusDetailedView extends StatelessWidget {
  final Bus bus;
  const BusDetailedView({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SSBDashboardPage(
      appBarTitle: 'Bus',
      isPadded: false,
      body: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: size.height, maxWidth: size.width),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 80.0),
                      color: Theme.of(context).primaryColor,
                      child: SizedBox(
                        height: 130.0,
                        child: Image.asset('images/bus.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150.0,
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  bus.busNo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                bus.route.split(',').join(' -> '),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Driver',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    '--->',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      bus.driver,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return SSBDashboardPageWithUser(
          // appBarTitle: "Hello, ${userData?['name']}",
          appBarTitle: 'Smart School Bus',
          builder: (user) => Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Card(
              elevation: 2,
              clipBehavior: Clip.hardEdge,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: [
                    // if (isAdmin)
                    getGridItem(
                      title: 'Map',
                      color: const Color.fromRGBO(237, 193, 196, 1.0),
                      assetImage: const AssetImage('images/maps.png'),
                      onTap: () {
                        model.navigateToMapsView();
                      },
                    ),
                    getGridItem(
                      title: 'Bus',
                      color: const Color.fromRGBO(243, 235, 188, 1.0),
                      assetImage: const AssetImage('images/bus.png'),
                      onTap: () {
                        model.navigateToBusView();
                      },
                    ),
                    // getGridItem(
                    //   title: 'Driver',
                    //   color: const Color.fromRGBO(254, 202, 172, 1.0),
                    //   assetImage: const AssetImage('images/driver.png'),
                    //   onTap: () {
                    //     model.navigateToMapsView();
                    //   },
                    // ),
                    getGridItem(
                      title: 'Student',
                      color: const Color.fromRGBO(197, 233, 255, 1.0),
                      assetImage: const AssetImage('images/student.png'),
                      onTap: () {
                        model.navigateToStudentView();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget getGridItem(
    {required String title,
    required Color color,
    required AssetImage assetImage,
    required void Function() onTap}) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        child: Card(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
              image: assetImage,
              height: 50.0,
            ),
          ),
        ),
      ),
      Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

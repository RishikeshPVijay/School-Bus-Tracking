import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page.dart';
import 'package:smart_school_bus/pages/ssb_page.dart';
import 'package:smart_school_bus/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) {
        return StreamBuilder<DocumentSnapshot>(
          stream: model.stream,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting ||
                !userSnapshot.hasData) {
              return SSBPage(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );
            }
            final userData = userSnapshot.data;
            String userType = userData?['user_type'];
            bool isAdmin = userType == UserType.admin.toShortString();
            bool isDriver = userType == UserType.driver.toShortString();
            bool isParent = userType == UserType.parent.toShortString();
            return SSBDashboardPage(
              // appBarTitle: "Hello, ${userData?['name']}",
              appBarTitle: 'Smart School Bus',
              body: Padding(
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
                            model.navigateToMapsView();
                          },
                        ),
                        getGridItem(
                          title: 'Driver',
                          color: const Color.fromRGBO(254, 202, 172, 1.0),
                          assetImage: const AssetImage('images/driver.png'),
                          onTap: () {
                            model.navigateToMapsView();
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

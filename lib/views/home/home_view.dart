import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/bus.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';
import 'package:smart_school_bus/views/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SSBDashboardPageWithUser(
      // appBarTitle: "Hello, ${userData?['name']}",
      appBarTitle: 'Smart School Bus',
      builder: (user) => ViewModelBuilder.reactive(
          onViewModelReady: (viewModel) => viewModel.user = user,
          viewModelBuilder: () => HomeViewModel(),
          builder: (context, model, child) {
            return Padding(
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
                      getGridItem(
                        title: 'Map',
                        color: const Color.fromRGBO(237, 193, 196, 1.0),
                        assetImage: const AssetImage('images/maps.png'),
                        onTap: () {
                          showBusSelectModal(context, model);
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
            );
          }),
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

void showBusSelectModal(BuildContext context, HomeViewModel viewModel) {
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
        child: StreamBuilder(
          stream: viewModel.getBusDataStream(),
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
            if (data == null) {
              return Container();
            }

            if (data.isEmpty) {
              return Center(
                child: Text(
                  viewModel.user.userType == UserType.admin
                      ? 'No buses added'
                      : 'No buses found with verified students added by you.',
                ),
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select a bus to view location',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      Bus bus = Bus.fromFirestore(data[index].data());
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          viewModel.navigateToMapsView(bus);
                        },
                        child: Card(
                          elevation: 0,
                          color: Colors.white,
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
          },
        ),
      );
    },
  );
}

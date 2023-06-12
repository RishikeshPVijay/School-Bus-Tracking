import 'package:smart_school_bus/views/add_bus_view/add_bus_view.dart';
import 'package:smart_school_bus/views/add_student_view/add_student_view.dart';
import 'package:smart_school_bus/views/bus_view/bus_view.dart';
import 'package:smart_school_bus/views/home/home_view.dart';
import 'package:smart_school_bus/views/initial_route_view/initial_route_view.dart';
import 'package:smart_school_bus/views/login/login_view.dart';
import 'package:smart_school_bus/views/sign_up/sign_up_view.dart';
import 'package:smart_school_bus/views/map/map_view.dart';
import 'package:smart_school_bus/views/student_view/student_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(
      page: LoginView,
      initial: true,
    ),
    MaterialRoute(
      page: SignUpView,
    ),
    MaterialRoute(
      page: HomeView,
    ),
    MaterialRoute(
      page: InitialRouteView,
    ),
    MaterialRoute(
      page: MapView,
    ),
    MaterialRoute(
      page: BusView,
    ),
    MaterialRoute(
      page: AddBusView,
    ),
    MaterialRoute(
      page: StudentView,
    ),
    MaterialRoute(
      page: AddStudentView,
    ),
  ],
)
class AppSetup {}

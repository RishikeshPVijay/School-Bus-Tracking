import 'package:smart_school_bus/views/home/home_view.dart';
import 'package:smart_school_bus/views/login/login_view.dart';
import 'package:smart_school_bus/views/sign_up/sign_up_view.dart';
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
  ],
)
class AppSetup {}

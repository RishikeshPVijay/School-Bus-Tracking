import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InitialRouteViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();
  final AuthenticationService _authenticationService =
      getIt<AuthenticationService>();

  Future handleStartUp() async {
    var isUserLoggedIn = await _authenticationService.isUserLoggedIn();
    if (isUserLoggedIn) {
      _replaceView(Routes.homeView);
    } else {
      _replaceView(Routes.loginView);
    }
  }

  Future<void> _replaceView(String viewName) async {
    await _navigationService.clearStackAndShow(viewName);
  }
}

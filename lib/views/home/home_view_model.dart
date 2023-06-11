import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();

  bool isViewLoading = true;

  void navigateToMapsView() => _navigate(Routes.mapView);
  void navigateToBusView() => _navigate(
      Routes.busView, const BusViewArguments(userType: UserType.admin));

  Future<void> _navigate(String viewName, [dynamic arguments]) async {
    await _navigationService.navigateTo(viewName, arguments: arguments);
  }
}

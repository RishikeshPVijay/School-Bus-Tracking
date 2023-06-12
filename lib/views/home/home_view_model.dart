import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();

  bool isViewLoading = true;

  void navigateToMapsView() => _navigate(Routes.mapView);
  void navigateToBusView() => _navigate(Routes.busView);

  Future<void> _navigate(String viewName) async {
    await _navigationService.navigateTo(viewName);
  }
}

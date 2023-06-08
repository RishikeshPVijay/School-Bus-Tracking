import 'package:smart_school_bus/app/app.router.dart';
import 'package:smart_school_bus/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final NavigationService _navigationService = getIt<NavigationService>();

  Future<void> gotoLoginView() async {
    await _navigationService.replaceWith(Routes.loginView);
  }
}

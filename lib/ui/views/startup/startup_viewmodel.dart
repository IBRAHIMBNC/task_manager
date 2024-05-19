import 'package:stacked/stacked.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/services/auth_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authService = locator<AuthService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 2));
    await _authService.init();
    if (_authService.isUserLoggedIn) {
      _navigationService.replaceWithHomeView();
    } else {
      _navigationService.replaceWithSignInView();
    }
  }
}

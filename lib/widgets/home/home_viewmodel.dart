import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ufirst_flutter_test/services/authentication_service.dart';
import 'package:ufirst_flutter_test/services/dependency_injector.dart';

class HomeViewModel extends StateNotifier<HomeState> {

  ///
  /// Static provider to get a state notifier provider
  ///
  static final homeProvider =
      StateNotifierProvider<HomeViewModel, HomeState>((ref) {
    return DependencyInjector.getInstance().resolve<HomeViewModel>();
  });

  ///
  /// Constructor for D.I.
  ///
  HomeViewModel(this._authenticationService) : super(HomeState(null, false));

  AuthenticationService _authenticationService;

  ///
  /// Starts the authentication process
  ///
  void startAuthentication() async {
    // Notifies the view about the authentication process starting //
    //state = HomeState(null, true);
    bool userAuthenticated = await _authenticationService.isUserAuthenticated();
    if (userAuthenticated != null && userAuthenticated == true) {
      // User is already authenticated //
      // Notifies the view everything's fine! //
      state = HomeState(true, false);
      return;
    }
    // Authenticates with the external provider and returns the result to the view //
    bool authenticated = await _authenticationService.loginWithExternalProvider();
    state = HomeState(authenticated, false);
  }
}

///
/// State class for home widget and viewmodel
///
class HomeState {

  HomeState(this.isAuthenticated, this.isAuthenticationInProgress);

  ///
  /// IsAuthenticated = null -> authentication not started
  /// true -> Authenticated
  /// false -> Not authenticated (error)
  ///
  final bool isAuthenticated;

  ///
  /// Whether the authentication is currently in progress or not
  ///
  final bool isAuthenticationInProgress;

}

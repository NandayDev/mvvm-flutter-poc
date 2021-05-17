import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

///
/// Authentication service, to authenticate with an external provider:
/// login and logout
///
abstract class AuthenticationService {

  ///
  /// Returns true if the user is authenticated, otherwise false
  ///
  Future<bool> isUserAuthenticated();

  ///
  /// Returns the id of the user, if authenticated
  ///
  String get userId;

  ///
  /// Logins with an external provider
  ///
  Future<bool> loginWithExternalProvider();

  ///
  /// Does the log out
  ///
  Future logout();
}

class FireBaseAuthenticationService implements AuthenticationService {

  bool _firebaseInitialized = false;
  bool _userAuthenticationSucceded;
  String _firebaseUserId;

  @override
  Future<bool> isUserAuthenticated() async {
    await _ensureFirebaseInitialized();
    return _userAuthenticationSucceded;
  }

  @override
  String get userId => _firebaseUserId;

  @override
  Future<bool> loginWithExternalProvider() async {

    _userAuthenticationSucceded = null;
    _firebaseUserId = null;
    await _ensureFirebaseInitialized();

    // Triggers the authentication flow //
    // For the sake of simplicity, we're using the google sign flow //
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // Error: probably the user didn't authenticate //
      return false;
    }
    // Obtains the auth details from the request //
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    // Creates a new credential //
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, returns the UserCredential //
    var userCredentials = await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredentials != null && userCredentials.user != null) {
      // We're going to use the user's email as an ID, for the sake of simplicity //
      // Although for production we should probably use user.uid, or some other property //
      _firebaseUserId = userCredentials.user.email;
      // Successful authentication //
      return true;
    }
    // Failed authentication //
    return false;
  }

  @override
  Future logout() async {
    _userAuthenticationSucceded = null;
    _firebaseUserId = null;
    await _ensureFirebaseInitialized();
    await FirebaseAuth.instance.signOut();
  }

  ///
  /// Ensures firebase is initialized (via the initializeApp method)
  /// and subscribes to the firebase auth callback, to receive a callback when the user logs in
  ///
  Future _ensureFirebaseInitialized() async {
    if (!_firebaseInitialized) {
      await Firebase.initializeApp();
      // Sets the listener on the FirebaseAuth instance //
      // FirebaseAuth.instance
      //     .authStateChanges()
      //     .listen((User user) {
      //   if (user == null) {
      //     print("User is currently signed out");
      //     _userAuthenticationSucceded = false;
      //   } else {
      //     print("User is signed in");
      //     _userAuthenticationSucceded = true;
      //   }
      // });
      _firebaseInitialized = true;
    }
  }



}
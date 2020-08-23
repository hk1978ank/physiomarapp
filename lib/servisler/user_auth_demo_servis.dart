
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/servisler/user_auth_base_servis.dart';

class UserAuthDemoServis implements UserAuthBaseServis
{

  @override
  Future<User> signInAnonimusUser() {
    // TODO: implement SignInAnonimusUser
    throw UnimplementedError();
  }

  @override
  Future<bool> signOutUser() {
    // TODO: implement SignOutUser
    throw UnimplementedError();
  }

  @override
  Future<User> currentUser() {
    // TODO: implement CurrentUser
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User> createEmailPassword(String email, String password) {
    // TODO: implement createEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<User> signInEmailPassword(String email, String password) {
    // TODO: implement signInEmailPassword
    throw UnimplementedError();
  }
}
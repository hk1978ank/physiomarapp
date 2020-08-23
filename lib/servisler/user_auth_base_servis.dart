
import 'package:physiomarapp/modeller/user_model.dart';

abstract class UserAuthBaseServis
{
  Future<bool> signOutUser();
  Future<User> signInAnonimusUser();
  Future<User> currentUser();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<User> signInEmailPassword(String email,String password);
  Future<User> createEmailPassword(String email,String password);




}
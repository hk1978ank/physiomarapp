import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/servisler/user_auth_base_servis.dart';
import 'package:physiomarapp/servisler/user_auth_demo_servis.dart';
import 'package:physiomarapp/servisler/user_auth_relase_servis.dart';
import 'package:physiomarapp/view_model/locatorSafakSayar.dart';

enum CalismaModu {Relase,Demo }

class UserAuthRepostory with ChangeNotifier implements UserAuthBaseServis
{
  CalismaModu calismaModu = CalismaModu.Relase;

  UserAuthDemoServis _authDemoServis = locator<UserAuthDemoServis>();
  UserAuthReleaseServis _authReleaseServis = locator<UserAuthReleaseServis>();

  @override
  Future<User> signInAnonimusUser() async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.signInAnonimusUser();
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.signInAnonimusUser();

      return sonuc;
    }

  }

  @override
  Future<bool> signOutUser() async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.signOutUser();
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.signOutUser();
      return sonuc;
    }

  }

  @override
  Future<User> currentUser() async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.currentUser();
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.currentUser();
      return sonuc;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.signInWithGoogle();
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.signInWithGoogle();
      return sonuc;
    }
  }

  @override
  Future<User> signInWithFacebook() async{
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.signInWithFacebook();
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.signInWithFacebook();
      return sonuc;
    }
  }

  @override
  Future<User> createEmailPassword(String email, String password) async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.createEmailPassword(email, password);
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.createEmailPassword(email, password);
      return sonuc;
    }
  }

  @override
  Future<User> signInEmailPassword(String email, String password) async {
    if ( calismaModu == CalismaModu.Demo) {
      var sonuc = await _authDemoServis.signInEmailPassword(email, password);
      return sonuc;
    }
    if ( calismaModu == CalismaModu.Relase) {
      var sonuc = await _authReleaseServis.signInEmailPassword(email, password);
      return sonuc;
    }
  }

}
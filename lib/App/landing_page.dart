import 'package:flutter/material.dart';
import 'package:physiomarapp/App/kullanici_giris_sayfasi.dart';
import 'package:physiomarapp/App/sign_in_page.dart';
import 'package:physiomarapp/sayfalar/qrkod_olustur.dart';
import 'package:physiomarapp/view_model/safaksayar_user_view_model.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import 'ana_sayfa.dart';

class LandIngPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _UserViewModel = Provider.of<UserViewModel>(context);
    if (_UserViewModel.userGET == null) {
      debugPrint("Landing Page user is null");
      //return SignInPage();
      return KullaniciGirisSayfasi();

    } else {

      return QRCodeOlustur();
      //return AnaSayfa();
    }
  }

}

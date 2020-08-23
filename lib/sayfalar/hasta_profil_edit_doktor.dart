import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/social_log_in_button.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaProfilEditDoktor extends StatefulWidget {
  @override
  _HastaProfilEditDoktorState createState() => _HastaProfilEditDoktorState();
}

class _HastaProfilEditDoktorState extends State<HastaProfilEditDoktor> {
  String _username, _password,_adsoyad,_cinsiyet,_yas,_boy,_kilo;
  final _formkey = GlobalKey<FormState>();

  Future<void> _formSubmit(BuildContext context) async {
    _formkey.currentState.save();
    debugPrint("Güncellenece Hasta ... Username: $_username  Password : $_password");
    final _userViewModel = Provider.of<UserViewModel>(context,listen: false);
    //await _userViewModel.createEmailPassword(email, password)
    //bool sonuc = await _userViewModel.createHastaPassword(_username, _password, _adsoyad, _cinsiyet, _yas, _boy, _kilo);
    User user = User(
      email: _userViewModel.hastaGET.email,
      userID: _userViewModel.hastaGET.userID,
      kilo:  _kilo,
      boy: _boy,
      cinsiyet: _cinsiyet,
      doktorID: _userViewModel.userGET.userID,
      adsoyad: _adsoyad,
      tur: "Hasta",
      yas: _yas
    );
    var sonuc = await _userViewModel.updateUserDB(user);
    if(sonuc!=null)
    {
      _userViewModel.hastaSET = sonuc;
      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
      //Future.delayed(Duration(milliseconds: 100))()=>Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel =
    Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: Text("Hasta Bilgileri"),),
      body:  SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    readOnly: true,
                    initialValue: _userViewModel.hastaGET.email,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      hintText: "Hasta Email Giriniz",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                   //   _username = sifre;
                    },
                  ),
                  TextFormField(
                    readOnly: true,
                    initialValue: _userViewModel.hastaGET.userID,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green,
                      ),
                      hintText: "Hasta Şifre Giriniz",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                    //  _password = sifre;
                    },
                  ),
                  TextFormField(
                    initialValue: _userViewModel.hastaGET.adsoyad,
                    decoration: InputDecoration(
                      hintText: "Hasta Ad Soyad Giriniz",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                      _adsoyad = sifre;
                    },
                  ),
                  TextFormField(
                    initialValue: _userViewModel.hastaGET.cinsiyet,
                    decoration: InputDecoration(

                      hintText: "Hasta cinsiyet",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                      _cinsiyet = sifre;
                    },
                  ),
                  TextFormField(
                    initialValue: _userViewModel.hastaGET.yas,
                    decoration: InputDecoration(
                      hintText: "Hasta Yaş Giriniz",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                      _yas = sifre;
                    },
                  ),
                  TextFormField(
                    initialValue: _userViewModel.hastaGET.boy,
                    decoration: InputDecoration(
                      hintText: "Hasta Boy Giriniz",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                      _boy = sifre;
                    },
                  ),
                  TextFormField(
                    initialValue: _userViewModel.hastaGET.kilo,
                    decoration: InputDecoration(
                      hintText: "Hasta Kilo Giriniz",
                      // labelText: "Parola",
                      // border: OutlineInputBorder(),
                    ),
                    onSaved: (sifre) {
                      _kilo = sifre;
                    },
                  ),

                  SizedBox(
                    height: 12,
                  ),

                  SocialLoginButton(
                    butonColor: Colors.blueAccent,
                    onPressed: () {
                      _formSubmit(context);
                    },
                    // butonColor: Colors.deepPurpleAccent,
                    // butonIcon: Icon(Icons.directions_run),
                    butonText: "Güncelle",
                    radius: 10,
                    yukseklik: 40,
                  ),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

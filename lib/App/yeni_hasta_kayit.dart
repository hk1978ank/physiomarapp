import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/social_log_in_button.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaKayit extends StatefulWidget {
  @override
  _HastaKayitState createState() => _HastaKayitState();
}

class _HastaKayitState extends State<HastaKayit> {

  String _username, _password,_adsoyad,_cinsiyet,_yas,_boy,_kilo;
  final _formkey = GlobalKey<FormState>();

  Future<void> _formSubmit(BuildContext context) async {
    _formkey.currentState.save();
    debugPrint("Yeni Hasta Kaydedilecek... Username: $_username  Password : $_password");
    final _userViewModel = Provider.of<UserViewModel>(context,listen: false);
    //await _userViewModel.createEmailPassword(email, password)
    bool sonuc = await _userViewModel.createHastaPassword(_username, _password, _adsoyad, _cinsiyet, _yas, _boy, _kilo);
    if(sonuc)
    {
      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
      //Future.delayed(Duration(milliseconds: 100))()=>Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _kressoftUserViewModel =
    Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: Text("Yeni Hasta Kayıt"),),
      body:_kressoftUserViewModel.userGET == null
          ?
      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                  //  initialValue: "fizyo@fizyo.hs",
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
                      _username = sifre;
                    },
                  ),
                  TextFormField(
                 //   initialValue: "123456",
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
                      _password = sifre;
                    },
                  ),
                  TextFormField(
                    //initialValue: "123456",
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
                    //initialValue: "123456",
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
                    //initialValue: "123456",
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
                    //initialValue: "123456",
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
                    //initialValue: "123456",
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
                    onPressed: () {
                      _formSubmit(context);
                    },
                    // butonColor: Colors.deepPurpleAccent,
                    // butonIcon: Icon(Icons.directions_run),
                    butonText: "Kaydet",
                    radius: 10,
                    yukseklik: 40,
                  ),

                ],
              ),
            ),
          ),
        ),
      ) :  Container(
    color: Colors.blue[50],
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 18,
            ),
            Text(
              "Lütfen Bekleyin...",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }


}

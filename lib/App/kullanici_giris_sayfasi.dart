import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/App/yeni_kullanici_kayit.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class KullaniciGirisSayfasi extends StatefulWidget {
  @override
  _KullaniciGirisSayfasiState createState() => _KullaniciGirisSayfasiState();
}

class _KullaniciGirisSayfasiState extends State<KullaniciGirisSayfasi> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fizyoterapistim'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Kullanıcı Girişi',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(

                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mail Adresi',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Şifre',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){

                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  //child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Giriş'),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);

                        _kullaniciGiris(nameController.text,passwordController.text,context);
                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text(''),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Yeni Kayıt',
                            //style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.of(context,
                                rootNavigator: true)
                                .push(CupertinoPageRoute(
                              //fullscreenDialog: true,
                              builder: (context) =>
                                  YeniKullaniciKayitSayfasi(),
                            ));
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }

  void _kullaniciGiris(String text, String text2, BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context,listen: false);
      User user = await _userViewModel.signInEmailPassword(text, text2);
  }
}

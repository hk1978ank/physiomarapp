import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class YeniKullaniciKayitSayfasi extends StatefulWidget {
  @override
  _YeniKullaniciKayitSayfasiState createState() => _YeniKullaniciKayitSayfasiState();
}

class _YeniKullaniciKayitSayfasiState extends State<YeniKullaniciKayitSayfasi> {
  int _cinsiyetE = 1;
  int _cinsiyetK = 0;

  String _adi,_email;
  String _cinsiyet ="Erkek";
  String _sifre1,_sifre2;

  int _boy;// = 0;
  int _kilo;// =0;
  int _yas;// =0;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Yeni Kullanıcı"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text(
              "Kaydet",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.transparent,
            focusColor: Colors.transparent,
            disabledColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onPressed: () {
              if((_sifre1==_sifre2) && _email.length>10) _kaydet(_adi,_cinsiyet,_email,_sifre1,_boy,_kilo,_yas,context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.person),
              title: new TextField(
                onChanged: (text)
                {
                  _adi = text;
                  setState(() {

                  });
                  print("Adı : >$_adi<");
                },
                decoration: new InputDecoration(
                  errorText: (_adi=="" || _adi==null) ? "Zorunlu Alan" : null,
                  hintText: "Adı Soyadı",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.accessibility),
              title: Row(
                children: <Widget>[
                  Text("Erkek "),
                  Radio(
                    value: _cinsiyetE,
                    groupValue: 1,
                    onChanged: (i){
//
                      print("i to $i");
                        setState(() {
                          _cinsiyetE = 1;
                          _cinsiyetK =0;
                          _cinsiyet ="Erkek";
                        });
                    },
                  ),
                  Text("         Kadın "),
                  Radio(
                    value: _cinsiyetK,
                    groupValue: 1,
                    onChanged: (i){
                      print("i22222to $i");
                      _cinsiyetE = 0;
                      _cinsiyetK =1;
                      _cinsiyet ="Kadın";
                      setState(() {

                      });
                    },
                  ),
                ],
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.mail_outline),
              title: new TextField(
                onChanged: (text)
                {
                  _email = text;
                  setState(() {

                  });
                  print("Adı : >$_email<");
                },
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                  errorText: (_email=="" || _email==null) ? "Zorunlu Alan" : null,
                  hintText: "E-Mail",
                ),
              ),
            ),

            new ListTile(
              leading: const Icon(Icons.lock_open),
              title: new TextField(
                obscureText: true,
                onChanged: (text)
                {

                  _sifre1 = text;
                  setState(() {

                  });
                  print("Adı : >$_adi<");
                },
                decoration: new InputDecoration(
                  hintText: "Şifre",
                  errorText: (_sifre1!=_sifre2 ) ? "Şifreler Uyumsuz" : (_sifre1==null || _sifre1=="") ? "Şifre Boş Geçilemez" : (_sifre1.length<6) ? "Şifre en az 6 karakter olmalı" : null,
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.lock_open),
              title: new TextField(
              obscureText: true,
                onChanged: (text)
                {
                  _sifre2 = text;
                  setState(() {

                  });

                },
                decoration: new InputDecoration(
                  errorText: (_sifre1!=_sifre2 ) ? "Şifreler Uyumsuz" : (_sifre2==null || _sifre2=="") ? "Şifre Boş Geçilemez" : (_sifre1.length<6) ? "Şifre en az 6 karakter olmalı" : null,

                  hintText: "Şifre Tekrar",
                ),
              ),
            ),
            const Divider(
              height: 1.0,
            ),
            new ListTile(
              leading: const Icon(Icons.swap_vert),
              title: new TextField(
                onChanged: (text)
                {
                  try
                  {
                    _boy = int.parse(text);
                  } catch(e)
                  {
                    _boy=0;
                  }

                  setState(() {

                  });
                  print("Boy : >$_boy<");
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  errorText: (_boy==null ||_boy<=30 || _boy>250 ) ? "Hatalı Giriş" : null,
                  hintText: "Boyunuz",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.accessibility),
              title: new TextField(
                onChanged: (text)
                {
                  try
                  {
                    _kilo = int.parse(text);
                  } catch(e)
                  {
                    _kilo=0;
                  }
                  setState(() {

                  });
                  print("_yas : >$_yas<");
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  errorText: (_kilo==null || _kilo<=3 || _kilo>120 ) ? "Hatalı Giriş" : null,
                  hintText: "Kilonuz",
                ),
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.today),
              title: new TextField(
                onChanged: (text)
                {
                  try
                  {
                    _yas = int.parse(text);
                  } catch(e)
                  {
                    _yas=0;
                  }

                  setState(() {

                  });
                  print("_yas : >$_yas<");
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  errorText: (_yas==null || _yas<=3 || _yas>120 ) ? "Hatalı Giriş" : null,
                  hintText: "Yaşınız",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _kaydet(String adi, String cinsiyet, String email, String sifre1, int boy, int kilo, int yas, BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context,listen: false);
    print("Cinsiyet :"+ _cinsiyet);
    //await _userViewModel.createEmailPassword(email, password)
    bool sonuc = await _userViewModel.createHastaPassword(email, sifre1, adi, cinsiyet, yas.toString(), boy.toString(), kilo.toString());
    if(sonuc)
    {

      print("Yeni kullanıcı kaydı başalılı");
      setState(() {

      });
      print(_userViewModel.userGET.toJson().toString());
      Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
      //Future.delayed(Duration(milliseconds: 100))()=>Navigator.pop(context);
    }

  }
}

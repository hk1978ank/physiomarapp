import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/App/yeni_hasta_kayit.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:physiomarapp/common_widget/social_log_in_button.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

enum FormType { Register, Login }

class _SignInPageState extends State<SignInPage> {
  String _username, _password;
  String _buttonText, _linkText;

  final _formkey = GlobalKey<FormState>();
  var _formType = FormType.Login;
  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login
        ? "Yeni kayıt olmak için tıklayın."
        : " Hasabınız var ise giriş yapmak için tıklayın.";

    final _kressoftUserViewModel =
        Provider.of<UserViewModel>(context, listen: true);

    Future<void> _formSubmit(BuildContext context) async {
      _formkey.currentState.save();
      debugPrint("Username: $_username  Password : $_password");
      final _userViewModel = Provider.of<UserViewModel>(context,listen: false);
      if (_formType == FormType.Login) {
        User user =
            await _userViewModel.signInEmailPassword(_username, _password);
      } else {
        User user =
            await _userViewModel.createEmailPassword(_username, _password);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Fizyoterapistim"),
        elevation: 0,
      ),
      //backgroundColor: Colors.grey.shade200,
      body: _kressoftUserViewModel.userGET == null
          ? SingleChildScrollView(
              //Ekrana taşmasını önledik...
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                     //   initialValue: "hk1978ank@gmail.com",
                        initialValue: "fizyo@fizyo.dr",
                        decoration: InputDecoration(
                          // errorText: _kressoftUserViewModel.userNameGirisiHataMesaji != null ? _kressoftUserViewModel.userNameGirisiHataMesaji : null,

                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.green,
                          ),
                          hintText: "Kullanıcı Adınızı yazınız",
                          labelText: "Kullanıcı Adı",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (girilendeger) {
                          _username = girilendeger;
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        initialValue: "123456",
                        decoration: InputDecoration(
                          //errorText: _kressoftUserViewModel.userPasswordGirisiHataMesaji !=null ? _kressoftUserViewModel.userPasswordGirisiHataMesaji : null,
                          prefixIcon: Icon(
                            Icons.lock_open,
                            color: Colors.green,
                          ),
                          hintText: "Şifrenizi Giriniz...",
                          labelText: "Parola",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (sifre) {
                          _password = sifre;
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
                        butonText: _buttonText,
                        radius: 10,
                        yukseklik: 40,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SocialLoginButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => HastaKayit(),
                          ));
                        },
                        // butonColor: Colors.deepPurpleAccent,
                        // butonIcon: Icon(Icons.directions_run),
                        butonText: "Yeni Kayıt",
                        radius: 10,
                        yukseklik: 40,
                      ),
                      /*
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _formType = _formType == FormType.Login
                                ? FormType.Register
                                : FormType.Login;
                          });
                        },
                        child: Text(_linkText),
                      ) */
                    ],
                  ),
                ),
              ),
            )
          : Container(
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

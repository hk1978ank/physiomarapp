import 'package:flutter/material.dart';

class SignInSayfasi extends StatefulWidget {
  @override
  _SignInSayfasiState createState() => _SignInSayfasiState();
}

class _SignInSayfasiState extends State<SignInSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kullanıcı Girişi"),),
      body: Center(
        child: Text("Kullanıcı Girişi"),
      ),

    );
  }
}

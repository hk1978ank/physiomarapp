import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/sayfalar/tanim_pdf_sayfasi.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import 'hasta_anketler_sayfasi.dart';

class HastalikDetaySayfasi extends StatefulWidget {
  @override
  _HastalikDetaySayfasiState createState() => _HastalikDetaySayfasiState();
}

class _HastalikDetaySayfasiState extends State<HastalikDetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(_userViewModel.hastaGET.adsoyad),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.red)
              ),
              child: Text("TANIM"),
              onPressed: () {
                print("Tanıma Tıklandı");
                Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(
                  //fullscreenDialog: true,
                  builder: (context) => TanimPdfSayfasi(path: _userViewModel.aktifHastalikGET,turu:"Tanim",),
                ));
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.red)
              ),
              child: Text("KLİNİK DEĞERLENDİRME"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(
                  //fullscreenDialog: true,
                  builder: (context) => TanimPdfSayfasi(path: _userViewModel.aktifHastalikGET,turu:"Değerlendirme",),
                ));
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.red)
              ),
              child: Text("ANKETLER"),
              onPressed: () {

                Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(
                  //fullscreenDialog: true,
                  builder: (context) => HastaAnketlerSayfasi(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

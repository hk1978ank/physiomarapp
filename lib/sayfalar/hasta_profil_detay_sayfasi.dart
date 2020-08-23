import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/sayfalar/hasta_anket_sonuclari.dart';
import 'package:physiomarapp/sayfalar/hasta_islemleri.dart';
import 'package:physiomarapp/sayfalar/hasta_profil_edit_doktor.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaProfilDetaySayfasi extends StatefulWidget {
  @override
  _HastaProfilDetaySayfasiState createState() =>
      _HastaProfilDetaySayfasiState();
}

class _HastaProfilDetaySayfasiState extends State<HastaProfilDetaySayfasi> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);

    String bedenkitleIndex = "Tanımsız";
    try {
      int hastaKilo = int.parse(_userViewModel.hastaGET.kilo);
      int boy = int.parse(_userViewModel.hastaGET.boy);
      int boykare = boy * boy;
      bedenkitleIndex = (hastaKilo / boykare).toStringAsFixed(5);
      //String sayi = String.format("%10.2f", sayi1f)) + "√3";
    } catch (e) {}
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
                  side: BorderSide(color: Colors.red)),
              child: Text("Hasta Bilgileri"),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(CupertinoPageRoute(
                  //fullscreenDialog: true,
                  builder: (context) => HastaProfilEditDoktor(),
                ));
                print("Hasta Bilgilerine Tıklandı");
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.red)),
              child: Text("Beden kitle index : " + bedenkitleIndex),
              onPressed: () {},
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.red)),
              child: Text("ANKET SONUÇLARI"),
              onPressed: () {
                _userViewModel
                    .readAnketSorulariWithHastsa(_userViewModel.hastaGET)
                    .then((value) {
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                    //fullscreenDialog: true,
                    builder: (context) => HastaAnketSonuclariSayfasi(),
                  ));
                });
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.red)),
              child: Text("ANKET EKLE"),
              onPressed: () async {
                String taramaSonucu = _userViewModel.hastaGET.userID;
                if (taramaSonucu != "") {
                  print("Tarama Sonucu hasta : " + taramaSonucu);
                  //var hasta = await _userViewModel.readHasta(taramaSonucu);
                  if (true) {
                    _userViewModel.readHastaliklar(context).then((value) {
                      print("Hasta boş değil");
                      Navigator.of(context, rootNavigator: true)
                          .push(CupertinoPageRoute(
                        //fullscreenDialog: true,
                        builder: (context) => HastaIslemleriSayfasi(),
                      ));
                    });
                  } else {
                    print("Hasta bulunamadı");
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

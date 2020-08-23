import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/sayfalar/hastalik_detay_sayfasi.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaIslemleriSayfasi extends StatefulWidget {
  @override
  _HastaIslemleriSayfasiState createState() => _HastaIslemleriSayfasiState();
}

class _HastaIslemleriSayfasiState extends State<HastaIslemleriSayfasi> {
  User _hasta;
  List<int> _seciliId;
  String _hastaAciklama;


  Color colorAcikMavi = Color(0xff1ab7ea);
  Color colorKoyuMavi = Color(0xff1190bb);
  Color colorBlack = Color(0xff131418);
  Color colorRed = Color(0xffff3300);
  Color colorGreen = Color(0xff09b83e);
  Color colorWhite = Colors.white;

  // List<HastaIslemleriSayfasi> _hastaliklarListem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);
    // _userViewModel.hastaliklarListemSET = _hastaliklarListem;
    // print("listemmm"+_hastaliklarListem.length.toString());

    //print("Hastalık listem " +_userViewModel.hastaliklarListemGET.length.toString());
    _hasta = _userViewModel.hastaGET;
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.grey,
        elevation: 0.1,
        title: Center(child: Text(_hasta.adsoyad, style: TextStyle(fontSize: 18)),),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              size: 18,
              //color: colorBlack,
            ),
            label: Text(
              "Kaydet",
              style: TextStyle(fontSize: 14),
            ),
            color: Colors.transparent,
            focusColor: Colors.transparent,
            disabledColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onPressed: () async {
              if (_userViewModel.aktifHastalikGET == null) {
                var sorgu2 = await PlatformDuyarliAlertDialog(
                  icerik: "Hiç bir hastalık seçmediniz.",
                  baslik: "Uyarı",
                  anaButonYazisi: "Tamam",
                  //iptalButonYazisi: "Hayır",
                ).goster(context);
              } else {
                print("_userViewModel.aktifHastalikGET : Null değği");
                if(_userViewModel.aktifHastalikGET !=null)
                if ((_hastaAciklama == null || _hastaAciklama == "")) {
                  var sorgu = await PlatformDuyarliAlertDialog(
                    icerik: "Açıklama yazmak istemediğinize emin misiniz? ",
                    baslik: "Dikkat",
                    anaButonYazisi: "Evet",
                    iptalButonYazisi: "Hayır",
                  ).goster(context);


                  if (sorgu == true) {
                    var aktifhastalik = _userViewModel.aktifHastalikGET;
                    aktifhastalik.doktorAciklama = _hastaAciklama;
                    _userViewModel.aktifHastalikSET=aktifhastalik;

                    Navigator.of(context, rootNavigator: true)
                        .push(CupertinoPageRoute(
                      //fullscreenDialog: true,
                      builder: (context) => HastalikDetaySayfasi(),
                    ));
                    //print("True basıldı");
                  }
                } else {

                  print("Açıklama null değil");
                  var aktifhastalik = _userViewModel.aktifHastalikGET;
                  aktifhastalik.doktorAciklama = _hastaAciklama;
                  _userViewModel.aktifHastalikSET=aktifhastalik;

                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                    //fullscreenDialog: true,
                    builder: (context) => HastalikDetaySayfasi(),
                  ));
                }
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
          /*
          itemCount: (_userViewModel.hastaliklarListemGET == null
              ? 1
              : _userViewModel.hastaliklarListemGET.length + 1),
          */
          itemCount: _userViewModel.hastaliklarListemGET.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                //margin: EdgeInsets.all(8),
                color: Colors.blue.shade100,
                height: 28,
                padding: EdgeInsets.only(top: 5, left: 10),
                width: MediaQuery.of(context).size.width,
                //alignment: Alignment.center,
                child: Text("Hastalıklar"),
              );
            } else if (index ==
                _userViewModel.hastaliklarListemGET.length + 1) {
              return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.grey[100],
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 4,
                      onChanged: (text) {
                        _hastaAciklama = text.trim();
                      },
                      decoration: InputDecoration(
                        labelText: "Hastaya ait bilgiler ",
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                      ),
                    ),
                  ));
            } else {
              return Card(
                child: ListTile(
                  onTap: () {
                    var sorgu = _userViewModel.hastaliklarListemGET[index - 1];
                    print(sorgu.toJson().toString());
                    if (sorgu.secili == true) {
                      sorgu.secili = false;
                    } else {
                      sorgu.secili = true;
                    }
                    _userViewModel.hastaliklarListemSETByID = sorgu;
                    setState(() {
                      // print("güncellendi");
                    });
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //verticalDirection: ,
                    children: <Widget>[
                      Text(_userViewModel.hastaliklarListemGET[index - 1].name),

                      /*
                      Text("($index)" +
                          _userViewModel.hastaliklarListemGET[index - 1].id
                              .toString() +
                          " " +
                          _userViewModel.hastaliklarListemGET[index - 1].name +
                          " " +
                          _userViewModel.hastaliklarListemGET[index - 1].secili
                              .toString()),
                      */
                      Icon(
                        _userViewModel.hastaliklarListemGET[index - 1].secili ==
                                true
                            ? Icons.check_circle
                            : Icons.remove_circle,
                        color: _userViewModel
                                    .hastaliklarListemGET[index - 1].secili ==
                                true
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

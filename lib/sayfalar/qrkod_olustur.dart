import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/sayfalar/hasta_anket_sonuclari.dart';
import 'package:physiomarapp/sayfalar/hasta_anketlerim_sayfasi.dart';
import 'file:///C:/APROJELER/Android/hakankucuk.com.app/physiomarapp/lib/sayfalar/hasta_islemleri.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'hasta_listesi.dart';
import 'hasta_profil_detay_sayfasi.dart';

class QRCodeOlustur extends StatefulWidget {
  @override
  _QRCodeOlusturState createState() => _QRCodeOlusturState();
}

class _QRCodeOlusturState extends State<QRCodeOlustur> {
  String qrCode = "hakan";
  //String hastaCode ="Taranmamış";
  Color colorAcikMavi = Color(0xff1ab7ea);
  Color colorKoyuMavi = Color(0xff1190bb);
  Color colorBlack = Color(0xff131418);
  Color colorRed = Color(0xffff3300);
  Color colorGreen = Color(0xff09b83e);
  Color colorWhite = Colors.white;

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);

    return _userViewModel.userGET.tur != "Doktor"
        ? Scaffold(
            //backgroundColor: Colors.brown,
            appBar: AppBar(
              // backgroundColor: Colors.red,// Color(0xeff3f4),
              title: Row(
                children: <Widget>[
                //  Icon(Icons.info),
                  Text("Fizyoterapistim",
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ],
              ),
            ),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    //height: MediaQuery.of(context).size.height/1.8,
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: QrImage(
                      data: _userViewModel.userGET.userID,
                      version: QrVersions.auto,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Oluşturulan Kodu Fizyoterapiste Gösteriniz"),
                  SizedBox(
                    height: 9,
                  ),
                  FlatButton(
                    //  padding: EdgeInsets.all(0),
                    child: Text(" Anketlerim "),
                    onPressed: () async {
                      _userViewModel.hastaSET = _userViewModel.userGET;
                      print("Hastamız : "+ _userViewModel.hastaGET.email);
                      //_userViewModel.anketSorulariSET=null;
                      var sonuc = await _userViewModel
                          .readAnketSorulariWithHastsa(_userViewModel.hastaGET)
                          .then((value) {
                        print("Sonuç kediii-1 :" +
                            _userViewModel.hastaAnketSorularimListGET.length
                                .toString());
                      });
                      print("Sonuç kediii -2 :" +
                          _userViewModel.hastaAnketSorularimListGET.length
                              .toString());
                      if (_userViewModel.hastaAnketSorularimListGET.length >
                          0) {
                        Navigator.of(context, rootNavigator: true)
                            .push(CupertinoPageRoute(
                          //fullscreenDialog: true,
                          builder: (context) => HastaAnketlerimSayfasi(),
                        ));
                      } else {
                        PlatformDuyarliAlertDialog(
                          anaButonYazisi: "Tamam",
                          icerik: "Kayıtlı anketiniz bulunmamaktadır.",
                          baslik: "Uyarı",
                        ).goster(context);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.blue, width: 3.0),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  //Text(_userViewModel.userGET.userID),
                  //SizedBox(height: 8,),
                  Text("Hoşgeldiniz : "+_userViewModel.userGET.adsoyad),
                  SizedBox(height: 8,),
                  FlatButton(
                    onPressed: () async {


                      await _userViewModel.signOutUser();


                      //qrCode = result.rawContent.toString()

                      /*Navigator.of(context,
                                                rootNavigator: true)
                                            .push(CupertinoPageRoute(
                                          //fullscreenDialog: true,
                                          builder: (context) =>
                                              HastaIslemleriSayfasi(),
                                        ));*/

                    },

                    child: Text("Çıkış"),
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: colorWhite,
              elevation: 0.1,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.info,
                    color: Colors.transparent,
                  ),
                  Text("Fizyoterapistim",
                      style: TextStyle(fontSize: 18, color: Colors.black54)),
                  Icon(
                    Icons.info,
                    size: 32,
                    color: colorAcikMavi,
                  ),
                ],
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      String taramaSonucu="X8j05ltnM7dNiIpNlpnGAnpFC1U2";
                      if (taramaSonucu!="") {
                        print("Tarama Sonucu hasta : "+ taramaSonucu);
                        var hasta = await _userViewModel.readHasta(taramaSonucu);
                        if(hasta!=null)
                        {
                          _userViewModel.readHastaliklar(context).then((value){
                            print("Hasta boş değil");
                            Navigator.of(context,
                                rootNavigator: true)
                                .push(CupertinoPageRoute(
                              //fullscreenDialog: true,
                              builder: (context) =>
                                  HastaIslemleriSayfasi(),
                            ));
                          });
                        } else
                        {
                          print("Hasta bulunamadı");
                        }
                      }
                    },
                    //child: Text("Demo Hasta: X8j05ltnM7dNiIpNlpnGAnpFC1U2 "),
                    child: Text(""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          InkWell(
                              onTap: () async {
                                var result = await BarcodeScanner.scan();
                                print(result
                                    .type); // The result type (barcode, cancelled, failed)
                                print(result.rawContent); // The barcode content
                                print(result
                                    .format); // The barcode format (as enum)
                                print(result.formatNote); // If a unknown forma

                                String taramaSonucu = result.rawContent;
                               // taramaSonucu = "vR7ouhZZThUH6nxvWD6JB9ODn8J3";
                                if (taramaSonucu!="") {
                                  print("Tarama Sonucu hasta : "+ taramaSonucu);
                                  var hasta = await _userViewModel.readHasta(taramaSonucu).then((value) async {
                                    value.doktorID = _userViewModel.userGET.userID;
                                    await _userViewModel.updateUserDB(value).then((value3) async {
                                      await _userViewModel.readHasta(value3.userID);
                                    });
                                  }).then((value){
                                    //_userViewModel.hastaSET = _userViewModel.hastaListesiGET[index];
                                    Navigator.of(context, rootNavigator: true)
                                        .push(CupertinoPageRoute(
                                      //fullscreenDialog: true,
                                      builder: (context) => HastaProfilDetaySayfasi(),
                                    ));
                                  });
/*
                                  if(hasta!=null)
                                    {
                                      _userViewModel.readHastaliklar(context).then((value){
                                        print("Hasta boş değil");
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .push(CupertinoPageRoute(
                                          //fullscreenDialog: true,
                                          builder: (context) =>
                                              HastaIslemleriSayfasi(),
                                        ));
                                      });
                                    } else
                                      {
                                        print("Hasta bulunamadı");
                                      }
                                  */

                                   //qrCode = result.rawContent.toString()

                                   /*Navigator.of(context,
                                                rootNavigator: true)
                                            .push(CupertinoPageRoute(
                                          //fullscreenDialog: true,
                                          builder: (context) =>
                                              HastaIslemleriSayfasi(),
                                        ));*/

                                } else
                                  {
                                    print("Okutmaktan vazgeçildi");
                                  }
                              },
                              child: Image.asset(
                                "images/qrcode.png",
                                height: 150,
                                width: 150,
                              )),
                          Text(
                            "Yeni Hasta",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Kaydı",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () async {
                              var sonuc = await _userViewModel.readHastaListesi(_userViewModel.userGET).then((value){
                                Navigator.of(context,
                                    rootNavigator: true)
                                    .push(CupertinoPageRoute(
                                  //fullscreenDialog: true,
                                  builder: (context) =>
                                      HastaListesiSayfasi(),
                                ));
                              });


                            },
                              child: Image.asset(
                            "images/hasta.png",
                            height: 150,
                            width: 150,
                          )),
                          Text(
                            "Kayıtlı",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Hastalar",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      //SizedBox(width: 30,),
                    ],
                  ),
                  FlatButton(
                    onPressed: () async {


            await _userViewModel.signOutUser();


                        //qrCode = result.rawContent.toString()

                        /*Navigator.of(context,
                                                rootNavigator: true)
                                            .push(CupertinoPageRoute(
                                          //fullscreenDialog: true,
                                          builder: (context) =>
                                              HastaIslemleriSayfasi(),
                                        ));*/

                      },

                    child: Text("Çıkış"),
                  ),
                ],
              ),
            ),
          );
  }
}

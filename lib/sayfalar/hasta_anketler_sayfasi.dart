import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/modeller/hastaliklar.dart';
import 'package:physiomarapp/modeller/user_model.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class HastaAnketlerSayfasi extends StatefulWidget {
  @override
  _HastaAnketlerSayfasiState createState() => _HastaAnketlerSayfasiState();
}
enum anketListesiTuru  {TumAnketler,OnerilenAnketler}

class _HastaAnketlerSayfasiState extends State<HastaAnketlerSayfasi> {

  anketListesiTuru anketturu =  anketListesiTuru.OnerilenAnketler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(_userViewModel.hastaGET.adsoyad + "h_a_s"),
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
            onPressed: () async {
              if (_userViewModel.aktifHastalikGET == null) {
                var sorgu2 = await PlatformDuyarliAlertDialog(
                  icerik: "Hiç Anket Seçmediniz...",
                  baslik: "Uyarı",
                  anaButonYazisi: "Tamam",
                  //iptalButonYazisi: "Hayır",
                ).goster(context);
              } else {
                print("Null değil 123");
                if(_userViewModel.aktifHastalikGET !=null)
                  if (true) {
                    var sorgu = await PlatformDuyarliAlertDialog(
                      icerik: "Anketleri göndermek istediğinize eminmisiniz? ",
                      baslik: "Fizyoterapistim",
                      anaButonYazisi: "Evet",
                      iptalButonYazisi: "Hayır",
                    ).goster(context);
                    bool db_kayit = false;
                    print("Anket türü :"+ anketturu.toString());
                    if(anketturu==anketListesiTuru.TumAnketler)
                      {
                        db_kayit = await _hastaAnketKayit(context,_userViewModel.hastaGET,_userViewModel.userGET,_userViewModel.anketListesiAllGET,_userViewModel);
                      } else
                        {
                          //_userViewModel.anketListesiAllSET =null;
                          print("bura111");
                          var kaydedilecekAnketler1 = _userViewModel.anketListesiAllGET;
                          var sorgu2 = _userViewModel.aktifHastalikGET;
                          List<int> seciliAnketIdleri = new List<int>();
                          kaydedilecekAnketler1.forEach((element) {
                            if(element.secili==true) {
                              seciliAnketIdleri.add(element.id);
                              print("Seçili Anket Idleri:"+ element.id.toString());
                              print("Seçili Anket Adı:"+ element.name);

                            }
                          });

                          print("------------------------");
                        int sayac = 1;
                        List<int> anketlisteidSon = new List<int>();
                          sorgu2.anketler.forEach((anket) {
                            anket.secili=false;

                            seciliAnketIdleri.forEach((sayacid) {
                            //  print("sayacid==sayac :" +sayacid.toString()+"=="+sayac.toString() );
                              if(sayacid==sayac)
                                {
                                  print("True Yapıldı:"+ anket.name);
                                  anket.secili=true;
                                  anketlisteidSon.add(anket.id);
                                }
                            });

                            print("Anketim :"+ anket.secili.toString()+ " Anket Adı :"+ anket.name+ " Anket Id:"+ anket.id.toString());
                            sayac++;
                          });

                          anketlisteidSon.forEach((element) {
                            print("AnketListesine Eklenece:"+ element.toString());
                          });

                          kaydedilecekAnketler1.forEach((anket) {
                            anket.secili=false;
                            anketlisteidSon.forEach((element) {
                              if(anket.id==element){
                                anket.secili=true;
                              }
                            });
                          });
                          _userViewModel.anketListesiAllSET = kaydedilecekAnketler1;
                          db_kayit = await _hastaAnketKayit(context,_userViewModel.hastaGET,_userViewModel.userGET,_userViewModel.anketListesiAllGET,_userViewModel);
                          //db_kayit = await _hastaAnketKayit(context,_userViewModel.hastaGET,                              _userViewModel.userGET,_userViewModel.anketListesiAllGET,_userViewModel);
                        }


                    if (sorgu == true && db_kayit) {
                      print("Sorgu True");
                      var sorgu = await PlatformDuyarliAlertDialog(
                        icerik: "Anketiniz hastaya gönderildi ",
                        baslik: "Fizyoterapistim",
                        anaButonYazisi: "Tamam",
                        //iptalButonYazisi: "Hayır",
                      ).goster(context);
                      if(sorgu==true)
                        {
                          //Navigator.pop(context);
                          Navigator.pushNamed(context, '/');
                        }
                      /*
                      Navigator.of(context, rootNavigator: true)
                          .push(CupertinoPageRoute(
                        //fullscreenDialog: true,
                        builder: (context) => HastalikDetaySayfasi(),
                      )); */
                      //print("True basıldı");
                    }
                  }
              }
            },
          ),
        ],
      ),
      body: anketturu==anketListesiTuru.TumAnketler ?
      ListView.builder(
        /*
          itemCount: (_userViewModel.hastaliklarListemGET == null
              ? 1
              : _userViewModel.hastaliklarListemGET.length + 1),
          */
          itemCount: _userViewModel.anketListesiAllGET.length+1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                //margin: EdgeInsets.all(8),
                //color: Colors.blue.shade100,
                height: 58,
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                //alignment: Alignment.center,
                child:
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: FlatButton(
                    child: Text("Önerilen Anketler"),
                    onPressed: (){
                      print("Önerilen tıklandı");
                      anketturu = anketListesiTuru.OnerilenAnketler;
                      _anketleriSifirla(_userViewModel,anketturu);

                     /*
                      _userViewModel.anketListesiAllGET.forEach((element) {
                        print("anket id : "+ element.id.toString());
                      });

                      */

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.blue,width: 2.0),
                    ),
                  ),
                ),



              );
            } else  {
              return Card(
                child: ListTile(
                  onTap: () async {
                    var sorgu = _userViewModel.anketListesiAllGET[index - 1];
                    var sorgu2 = PlatformDuyarliAlertDialog(
                      baslik: "Bilgi",
                      icerik: sorgu.info,
                      anaButonYazisi: "Tamam",
                    ).goster(context);

                      // print("güncellendi");

                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //verticalDirection: ,
                    children: <Widget>[

                      Expanded(
                        child: Text(_userViewModel.anketListesiAllGET[index - 1].name,
                          style: TextStyle(fontSize: 16,),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          var sorgu = _userViewModel.anketListesiAllGET[index - 1];
                          print(sorgu.toJson().toString());
                          if (sorgu.secili == true) {
                            sorgu.secili = false;
                          } else {
                            sorgu.secili = true;
                          }
                          //_userViewModel.hastaliklarListemSETByID = sorgu.id;
                          setState(() {
                            // print("güncellendi");
                          });
                        },
                        child: Icon(

                          _userViewModel.anketListesiAllGET[index - 1].secili ==
                              true
                              ? Icons.check_circle
                              : Icons.remove_circle,
                          color: _userViewModel
                              .anketListesiAllGET[index - 1].secili ==
                              true
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }) :
      ListView.builder(
          //Önerilen Anketler
          itemCount: _userViewModel.aktifHastalikGET.anketler.length+1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                //margin: EdgeInsets.all(8),
                //color: Colors.blue.shade100,
                height: 58,
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                //alignment: Alignment.center,
                child:
                   Padding(
                     padding: const EdgeInsets.only(left: 20,right: 20),
                     child: FlatButton(
                          child: Text("Tüm Anketler"),
                          onPressed: (){
                            print("Tüm anketlere tıklandı");
                            anketturu = anketListesiTuru.TumAnketler;
                            _anketleriSifirla(_userViewModel,anketturu);

                            /*
                            _userViewModel.anketListesiAllGET.forEach((element) {
                              print("anket id : "+ element.id.toString());
                            });

                             */

                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.blue,width: 2.0),
                          ),
                        ),
                   ),



              );
            } else  {
              return Card(
                child: ListTile(
                  onTap: () async {
                    var sorgu = _userViewModel.anketListesiAllGET[index - 1];
                    var sorgu2 = PlatformDuyarliAlertDialog(
                      baslik: "Bilgi",
                      icerik: sorgu.info,
                      anaButonYazisi: "Tamam",
                    ).goster(context);

                    // print("güncellendi");

                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //verticalDirection: ,
                    children: <Widget>[
                      
                      Expanded(
                        child: Text(
                            _userViewModel.aktifHastalikGET.anketler[index - 1].name ,
                          style: TextStyle(fontSize: 16,),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          var sorgu = _userViewModel.anketListesiAllGET[index - 1];
                          print(sorgu.toJson().toString());
                          if (sorgu.secili == true) {
                            sorgu.secili = false;
                          } else {
                            sorgu.secili = true;
                          }
                          //_userViewModel.hastaliklarListemSETByID = sorgu.id;
                          setState(() {
                            // print("güncellendi");
                          });
                        },
                        child: Icon(

                          _userViewModel.anketListesiAllGET[index - 1].secili ==
                              true
                              ? Icons.check_circle
                              : Icons.remove_circle,
                          color: _userViewModel
                              .anketListesiAllGET[index - 1].secili ==
                              true
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),

    );
  }

  Future<bool>_hastaAnketKayit(BuildContext context, User aktifHasta, User doktor, List<Anketler> hastaliklar,UserViewModel _userViewModel) async {

    if(anketturu==anketListesiTuru.TumAnketler)
      {
        print("Anket kayıt işlemi başladı");
        List<Anketler> _anketler = new List<Anketler>();
        hastaliklar.forEach((anket) {
          if(anket.secili!=null)
          {
            if(anket.secili==true)
            {
              //anket.hastaDoktorAciklama =
              _anketler.add(anket);
              print("Seçili Anket ID:"+anket.id.toString());
            }

          }
        });
        if(_anketler!=null)
        {

          //var sonuc = await _userViewModel.hastaAnketOlurtur(context, hastaGET, userGET, _userViewModel.aktifHastalikGET, _userViewModel.anketSorulariGET);
          var sonuc = await _userViewModel.hastaAnketOlurtur(context, aktifHasta, doktor, _userViewModel.aktifHastalikGET, hastaliklar);
        }
      } else
        {
          print("Anket kayıt işlemi başladı - Önerilen Anketler");
          List<Anketler> _anketler = new List<Anketler>();

          _userViewModel.aktifHastalikGET.anketler.forEach((anket) {
            if(anket.secili!=null)
            {
              if(anket.secili==true)
              {
                //anket.hastaDoktorAciklama =
                _anketler.add(anket);
                print("Seçili Anket ID:"+anket.id.toString());
              }

            }
          });
          if(_anketler!=null)
          {

            //var sonuc = await _userViewModel.hastaAnketOlurtur(context, hastaGET, userGET, _userViewModel.aktifHastalikGET, _userViewModel.anketSorulariGET);
            var sonuc = await _userViewModel.hastaAnketOlurtur(context, aktifHasta, doktor, _userViewModel.aktifHastalikGET, hastaliklar);
          }

        }


    return Future<bool>.value(true);
  }

  void _anketleriSifirla(UserViewModel _userViewModel, anketListesiTuru anketturu) async {
    /*

    if(anketturu==anketListesiTuru.TumAnketler)
      {
        await _userViewModel.readHastaliklar(context).then((value){

          setState(() {

          });
        });
      } else {
        await _userViewModel.readAnketSorulariWithHastsa(_userViewModel.hastaGET).then((value){
          setState(() {

          });
        });
    }
*/

    if(anketturu==anketListesiTuru.TumAnketler)
      {
        var sorgu = _userViewModel.anketListesiAllGET;
        //List<Anketler> yeniAnketListesi = new List<Anketler>();
        sorgu.forEach((anket) {
          anket.secili=false;
          //  yeniAnketListesi.add(anket);
        });
        _userViewModel.anketListesiAllSET = sorgu;

      } else
        {
          var sorgu = _userViewModel.anketListesiAllGET;
          //List<Anketler> yeniAnketListesi = new List<Anketler>();
          sorgu.forEach((anket) {
            anket.secili=false;
            //  yeniAnketListesi.add(anket);
          });
          _userViewModel.anketListesiAllSET = sorgu;
        }


  var sorgu2 = _userViewModel.aktifHastalikGET;
  //List<Anketler> aktifAnketler = new List<Anketler>();
  sorgu2.anketler.forEach((anket2) {
    anket2.secili=false;
  //aktifAnketler.add(anket2);
  });
  //sorgu2.anketler = aktifAnketler;
  _userViewModel.aktifHastalikSET = sorgu2;

  setState(() {

  });


  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/sayfalar/anket_sorularini_coz_sayfasi2.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaAnketlerimSayfasi extends StatefulWidget {
  @override
  _HastaAnketlerimSayfasiState createState() => _HastaAnketlerimSayfasiState();
}

class _HastaAnketlerimSayfasiState extends State<HastaAnketlerimSayfasi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);
    print("Anket Sayısı : "+_userViewModel.hastaAnketSorularimListGET.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Hasta Anketlerim"),
      ),
      body: ListView.builder(
          itemCount: (_userViewModel.hastaAnketSorularimListGET == null
              ? 1
              : _userViewModel.hastaAnketSorularimListGET.length +0),
          itemBuilder: (context, index) {
            if (_userViewModel.hastaAnketSorularimListGET == null) {
              return Container(
                //margin: EdgeInsets.all(8),
                //color: Colors.blue.shade100,
                height: 58,
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                //alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FlatButton(
                    child: Text("Henüz bir anketiniz bulunmamaktadır."),
                    onPressed: () {
                      print("Önerilen tıklandı");
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                ),
              );
            } else {
              return Card(
                child: ListTile(
                  onTap: () async {
                    //  var sorgu = _userViewModel.anketListesiAllGET[index - 1];
                    /*
                    var sorgu2 = PlatformDuyarliAlertDialog(
                      baslik: "Bilgi",
                      icerik: sorgu.info,
                      anaButonYazisi: "Tamam",
                    ).goster(context);


                     */
                    // print("güncellendi");
                    if(_userViewModel
                        .hastaAnketSorularimListGET[index]
                        .cevaplamaTarihi=="")
                      {
                        var anketsorularim =  _userViewModel
                            .hastaAnketSorularimListGET[index];
                        _userViewModel.anketSorulariSET = anketsorularim;
                        Navigator.of(context, rootNavigator: true)
                            .push(CupertinoPageRoute(
                          //fullscreenDialog: true,

                          builder: (context) => AnketSorulariniCoz2(),
                        ));
                      } else
                        {
                            PlatformDuyarliAlertDialog(
                              anaButonYazisi: "Tamam",
                              icerik: "Çözülmüş anket üzerinde işlem yapamazsınız",
                              baslik: "Uyarı",

                            ).goster(context);
                        }



                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    //verticalDirection: ,
                    children: <Widget>[
                      Expanded(
                        child: Text(

                              _userViewModel
                                  .hastaAnketSorularimListGET[index]
                                  .data.anketAdi
                                  .toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          var sorgu = _userViewModel
                              .hastaAnketSorularimListGET[index];
                          //print(sorgu.toJson().toString());
                          //Tıklanılan ankete göre detaya git

                          setState(() {
                            // print("güncellendi");
                          });
                        },
                        child: Icon(
                          _userViewModel
                              .hastaAnketSorularimListGET[index]
                              .cevaplamaTarihi=="" ?
                          Icons.remove_circle : Icons.check_circle,
                          color:  _userViewModel
                              .hastaAnketSorularimListGET[index]
                              .cevaplamaTarihi=="" ? Colors.grey : Colors.green,
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
}

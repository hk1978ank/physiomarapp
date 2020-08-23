import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:physiomarapp/sayfalar/hasta_anket_sonuclari_detay_sayfasi.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaAnketSonuclariSayfasi extends StatefulWidget {
  @override
  _HastaAnketSonuclariSayfasiState createState() =>
      _HastaAnketSonuclariSayfasiState();
}

class _HastaAnketSonuclariSayfasiState
    extends State<HastaAnketSonuclariSayfasi> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(_userViewModel.hastaGET.adsoyad),
      ),
      body: ListView.builder(
          itemCount: _userViewModel.hastaAnketSorularimListGET.length,
          itemBuilder: (context, index) {
            String formattedDate = "";
            try
            {
              DateTime now = DateTime.parse(_userViewModel.hastaAnketSorularimListGET[index].cevaplamaTarihi);
              formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(now);
            } catch(e)
            {

            }

            return Card(
              child: ListTile(
                onTap: () {
                  var sorgu = _userViewModel.hastaAnketSorularimListGET[index ];
                  Navigator.of(context, rootNavigator: true)
                      .push(CupertinoPageRoute(
                    //fullscreenDialog: true,
                    builder: (context) => HastaAnketSonuclariDetaySayfasiDoktor(
                      anket: _userViewModel.hastaAnketSorularimListGET[index],
                    ),
                  ));
                  //print(sorgu.toJson().toString());
                },
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  //verticalDirection: ,
                  children: <Widget>[
                    Text( _userViewModel.hastaAnketSorularimListGET[index].cevaplamaTarihi ==""
                        ? "Cevap Bekleniyor"
                        : formattedDate),
                    Icon(
                      _userViewModel.hastaAnketSorularimListGET[index].cevaplamaTarihi !=""
                          ? Icons.check_circle
                          : Icons.remove_circle,
                      color: _userViewModel.hastaAnketSorularimListGET[index].cevaplamaTarihi !=""
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ],
                ),
                title: Text(_userViewModel.hastaAnketSorularimListGET[index ].data.anketAdi.toString()),
              ),
            );
          }),
    );
  }
}

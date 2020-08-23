import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/sayfalar/hasta_profil_detay_sayfasi.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HastaListesiSayfasi extends StatefulWidget {
  @override
  _HastaListesiSayfasiState createState() => _HastaListesiSayfasiState();
}

class _HastaListesiSayfasiState extends State<HastaListesiSayfasi> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıtlı Hasta Listesi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
            itemCount:  _userViewModel.hastaListesiGET.length ?? 0,
            itemBuilder: (context,index)
          {
            return Column(
              children: <Widget>[
                ListTile(
                  onTap: (){
                    _userViewModel.hastaSET = _userViewModel.hastaListesiGET[index];
                    Navigator.of(context, rootNavigator: true)
                        .push(CupertinoPageRoute(
                      //fullscreenDialog: true,
                      builder: (context) => HastaProfilDetaySayfasi(),
                    ));
                  },
                  title: Text(_userViewModel.hastaListesiGET[index].adsoyad),
                  subtitle: Text(_userViewModel.hastaListesiGET[index].email),
                ),
                Divider(
                  height: 1,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class AyarlarSayfasi extends StatefulWidget {
  @override
  _AyarlarSayfasiState createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Text("Güncelleniyor..."),
            Text("v.1.0.9"),

            hataListesi(context, _userViewModel),

          ],
        ),
      ),
    );
  }

  hataListesi(BuildContext context, UserViewModel userViewModel) {
    List<String> hataListesi = userViewModel.hataListesiGET;
    if (hataListesi == null) return Text("Hata Yok");

    return Expanded(
      child: ListView.builder(
          itemCount: hataListesi.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("$index  :" + hataListesi[index]),
              subtitle: Text("----"),
            );
          }),
    );
  }
}


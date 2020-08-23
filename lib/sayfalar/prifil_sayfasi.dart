import 'package:flutter/material.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class ProfilSayfasi extends StatefulWidget {
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  @override
  Widget build(BuildContext context) {
    final _userViewModel =
    Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(title: Text("Profil Sayfası"),),
      body: Center(child:
        Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Çıkış"),
              onPressed: (){
              _cikisYap(context,_userViewModel);

              },
            )
          ],
        )

        ,),
    );
  }

  void _cikisYap(BuildContext context, userViewModel) async {

      var sonuc = await userViewModel.signOutUser();
      setState(() {

      });


  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class PrinterSayfasi extends StatefulWidget {
  @override
  _PrinterSayfasiState createState() => _PrinterSayfasiState();
}

class _PrinterSayfasiState extends State<PrinterSayfasi> {
  //bool kullanici_koltrol_edildimi = true;

  @override
  void initState() {
    print("Profil Sayfası İnitSatate Oluştu");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Printer queue",
            style: TextStyle(
              fontSize: 18,
            ),
          )),
      body: Center(
        child: CircularProgressIndicator(
          semanticsLabel: _userViewModel.translate("lutfen_bekleyin", context),
        ),
      ),
    );
  }
}



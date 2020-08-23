import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';

class HastaAnketSonuclariDetaySayfasiDoktor extends StatefulWidget {
  final AnketSorulariModelim anket;

  const HastaAnketSonuclariDetaySayfasiDoktor({Key key, this.anket})
      : super(key: key);

  @override
  _HastaAnketSonuclariDetaySayfasiDoktorState createState() =>
      _HastaAnketSonuclariDetaySayfasiDoktorState();
}

class _HastaAnketSonuclariDetaySayfasiDoktorState
    extends State<HastaAnketSonuclariDetaySayfasiDoktor> {
  @override
  Widget build(BuildContext context) {
    var anket = widget.anket;
    return Scaffold(
      appBar: AppBar(
        title: Text("Anket sonucu"),
      ),
      body: ListView.builder(
          itemCount: anket.data.sorular.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Center(
                child: Container(
                  padding: EdgeInsets.only(top: 8),
                  height: 28,
                  child: Text(
                    "Hasta Anket Sonucu",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            } else {
              return Card(
                child: ListTile(
                  title: Text(anket.data.sorular[index - 1].soru),
                  subtitle: Row(
                    children: <Widget>[
                      Text("Cevap : ",style: TextStyle(color: Colors.red),),
                      Text(_secenekgetir(anket.data.sorular[index - 1]),style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  String _secenekgetir(Sorular sorular) {
    var secenekler = sorular.secenekler;
    String gidecekText = "";
    secenekler.forEach((element) {
      if (element.secim != null) {
        if(element.secim==element.secenek)
          {
            print("Eşit :"+ element.secim);
            gidecekText = element.secim;

          }
      }
    });
    return gidecekText;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:physiomarapp/modeller/hastaliklar.dart';


class TanimPdfSayfasi extends StatefulWidget {
  final HastaliklarModel path;
  final String turu;

  const TanimPdfSayfasi({Key key, this.path, this.turu}) : super(key: key);
  @override
  _TanimPdfSayfasiState createState() => _TanimPdfSayfasiState();
}

class _TanimPdfSayfasiState extends State<TanimPdfSayfasi> {

  PDFDocument doc;
  String baslik;

  //String corruptedPathPDF = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String dosyaAdi;
    if(widget.turu=="Tanim") {
      dosyaAdi = widget.path.tanim + ".pdf";
      baslik = widget.path.name;
    }
      if(widget.turu!="Tanim") {
        dosyaAdi = widget.path.degerlendirme + ".pdf";
        baslik = widget.path.name;
      }
      //String dosyaAdi = widget.path.tanim+".pdf";

      print("Yüklenecek Döküman :"+dosyaAdi);
      //var sonuc = dokumanYukle(context,"ankilozanSpondilitTanim.pdf").then((value){
      dokumanYukle(context,dosyaAdi);


// Load from assets

//    fromAsset('pdf/ankilozanSpondilitTanim.pdf', 'ankilozanSpondilitTanim.pdf').then((f) {
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(baslik),
      ),
      body: Center(
        child: doc==null ? Center() : PDFViewer(document: doc),
      ),

    );
  }

  dokumanYukle(BuildContext context, String dosyaadi)  async {
  try{
    //var sonuc =  await PDFDocument.fromAsset('pdf/'+dosyaadi);
      await PDFDocument.fromAsset('pdf/'+dosyaadi).then((value){
        print("Dosya Yüklendi");
      setState(() {

        doc = value;
      });
    });
  //  return sonuc;
  } catch(e)
    {
      print("Hata :"+e.toString());
    }
   //return null;

  }

}





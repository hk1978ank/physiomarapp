import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YardimSayfasi extends StatefulWidget {
  String baslik;
  String icerik;

  YardimSayfasi({@required this.baslik, @required this.icerik});

  @override
  _YardimSayfasiState createState() => _YardimSayfasiState();
}

class _YardimSayfasiState extends State<YardimSayfasi> {
  @override
  Widget build(BuildContext context) {
    String _baslik = widget.baslik;
    String _icerik = widget.icerik;
    return Scaffold(

      appBar: AppBar(
        title: Text(_baslik),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Text(_icerik),
        ),
      ),
    );
  }
}

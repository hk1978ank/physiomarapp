import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class ChatDenemeSayfasi extends StatefulWidget {
  @override
  _ChatDenemeSayfasiState createState() => _ChatDenemeSayfasiState();
}

class _ChatDenemeSayfasiState extends State<ChatDenemeSayfasi> {
  //bool baglimi = false;
  Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Sayfası - Durum "),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildMesajListesi(context,"genel"),

          ],
        ),
      ),
    );
  }

  _buildMesajListesi(BuildContext context, String roomName) {
    roomName = "genel";
      int i = 0;
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
   // var getMessage = _userViewModel.getRoomMessage(roomName, _userViewModel.userGET);
    return StreamBuilder(
      stream: _firestore.collection("room").document(roomName).collection("mesajlar").snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot)
      {
        if(snapshot.hasError)
          {
            return Text("Hata Oluştu :"+snapshot.error);
          }
        if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Text("Bağlanıyor...");
          }
        if(snapshot.connectionState == ConnectionState.active)
          {
            //baglimi = true;
          }
          return Expanded(
            child: ListView(
              children: snapshot.data.documents
              .map((doc) => ListTile(
                title: Text(doc["mesaj"]),
                subtitle: Text(doc["roomName"]),
              ))
                  .toList(),
            ),
          );
      },
    );
  }



}

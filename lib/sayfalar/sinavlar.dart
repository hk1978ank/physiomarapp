import 'package:flutter/material.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class Sinavlar extends StatefulWidget {
  @override
  _SinavlarState createState() => _SinavlarState();
}

Widget ListeyiOlustur(BuildContext context, int index, UserViewModel _userViewModel) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
        width: 0.2,
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      color: Colors.white30,
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(
      left: 5,
      right: 5,
    ),
    height: 100,
    //color: Colors.tealAccent,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PopupMenuButton(
              color: Colors.white,
              //padding: EdgeInsets.only(left: 5),
              //shape:
              icon: Icon(Icons.dehaze),
              elevation: 1,
              onSelected: (string) {},
              itemBuilder: (_) => <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                    child: Text(_userViewModel.translate("favoriye_ekle", context)), value: 'Doge'),
                new PopupMenuItem<String>(
                    child: Text(_userViewModel.translate("listeden_cikar", context)), value: 'Lion'),
              ],
            ),

            Container(
              child: Text(
                _userViewModel.translate("cok_yakinda_guncellenecek", context),
                style: TextStyle(fontSize: 20),
              ),
              margin: EdgeInsets.only(top: 10),
            ),
            Icon(Icons.star,color: Colors.black,size: 28,),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Icon(Icons.attach_file),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    _tarihiGoster(context),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 0),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Icon(Icons.attach_file),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    "#YKSTurkey",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ],
              ),
              margin: EdgeInsets.only(top:8),
            ),
          ],
        ),

      ],
    ),
  );

//    return ListTile(title: Text("Deneme $index"),);
}

String _tarihiGoster(BuildContext context) {
  Locale myLocale = Localizations.localeOf(context);
  var dateFormat = new DateFormat.yMMMMd(myLocale.toString()).add_jm();
  // final df = new DateFormat('dd-MMM-yyyy');
  //print("Gelen Tarih : $");
  //print("Dönüşen Tarih : " + dateFormat.format(_tarih));
  //return dateFormat.format(DateTime.parse("25-08-1978"));
  return dateFormat.format(DateTime.now());
//  return dateFormat.format(DateTime.now());
}
Widget ListeBasligiOlustur(BuildContext context, int index, UserViewModel _userViewModel) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.brown,
        width: 0.2,
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      color: Colors.white30,
    ),
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.only(
      left: 5,
      right: 5,
    ),
    height: 100,
    //color: Colors.tealAccent,
    child: Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

              child: Text(
                _userViewModel.translate("siralama_yontemi", context),
                style: TextStyle(fontSize: 22),
              ),
              margin: EdgeInsets.only(top: 10),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Icon(Icons.attach_file),
            Container(
              child: Row(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.update,size: 32,),
                    label: Text(_userViewModel.translate("tarihe_gore", context),style: TextStyle(color: Colors.brown),),
                    onPressed: (){},
                  ),
                  SizedBox(width: 10,),
                  FlatButton.icon(
                    icon: Icon(Icons.text_fields,size: 32,),
                    label: Text(_userViewModel.translate("sinav_adina_gore", context),style: TextStyle(color: Colors.brown),),
                    onPressed: (){},
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 0),
            ),
          ],
        ),

      ],
    ),
  );

//    return ListTile(title: Text("Deneme $index"),);
}
class _SinavlarState extends State<Sinavlar> {
  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Deneme App Bar"),
      ), */
      body: CustomScrollView(
        slivers: <Widget>[
          // Add the app bar to the CustomScrollView.
          SliverAppBar(
            title: Text(_userViewModel.translate("sinav_takvimi", context)),
            floating: true,
           // flexibleSpace: Placeholder(),
            expandedHeight: 50,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListeBasligiOlustur(context, index,_userViewModel);
                //return  ListTile(title: Text("Kelam $index"),);
              },
              childCount: 1,
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListeyiOlustur(context, index,_userViewModel);
                //return  ListTile(title: Text("Kelam $index"),);
              },
              childCount: 1,
            ),
          ),

          // Display a placeholder widget to visualize the shrinking s
        ],
      ),
    );
  }
}

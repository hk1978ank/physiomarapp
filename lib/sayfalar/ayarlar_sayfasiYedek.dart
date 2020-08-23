import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:physiomarapp/view_model/safaksayar_user_view_model.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AyarlarPageYedek extends StatefulWidget {
  @override
  _AyarlarPageState createState() => _AyarlarPageState();
}

class _AyarlarPageState extends State<AyarlarPageYedek> {
  final TextEditingController eCtrl = new TextEditingController();

  DateTime _tarih;
  DateTime _saat;
  DateTime _sistemSaati;


  DateTime get sistemSaatiGET => DateTime.now();
  set sistemSaatiSET(DateTime value) {
    if(value==null) _tarih=DateTime.now(); else
      _sistemSaati=value;
  }

  DateTime get tarihGET => _tarih;
  set tarihSET(DateTime value) {
    if(value==null) _tarih=DateTime.now(); else
      _tarih = value;

  }


  DateTime get saatGET => _saat;
  set saatSET(DateTime value) {
    if(value==null) _saat=DateTime.now(); else
      _saat = value;

  }




  // _saatS = DateFormat('kk:mm:ss').format(value);





  @override
  void initState() {
    super.initState();
    saatGET; tarihGET; sistemSaatiGET;

  }

  @override
  Widget build(BuildContext context) {
    SafaksayarUserViewModel _safaksayarUserViewModel =
    Provider.of<SafaksayarUserViewModel>(context);


    Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    Locale myLocale = Localizations.localeOf(context);

    if(tarihGET==null){
      tarihSET = _safaksayarUserViewModel.userSafakSayarModelGET.sayicalakTarih;
    }
    if(saatGET==null){
      saatSET = _safaksayarUserViewModel.userSafakSayarModelGET.sayicalakTarih;
    }
    void _tarihiGoster(BuildContext context) {
      DatePicker.showDatePicker(
        context,
        showTitleActions: true,
        minTime: DateTime(DateTime.now().year, 1, 1),
        maxTime: DateTime(2025, 12, 1),
        theme: DatePickerTheme(
            cancelStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            headerColor: Colors.orange,
            backgroundColor: Colors.blue,
            itemStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        },
        onConfirm: (date) {
          // setState(() {
          tarihSET = date;
          _safaksayarUserViewModel.tarihVeSaatiBirlestir(tarihGET, saatGET);
          //});

          print('Tarih confirm $date');
        },
        currentTime: DateTime.now(),
        locale: LocaleGetir(myLocale), // LocaleType.tr,
        //  locale: myLocale
      );
    }

    void _saatiGoster(BuildContext context) {
      DatePicker.showTimePicker(
        context,
        theme: DatePickerTheme(
            cancelStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            headerColor: Colors.orange,
            backgroundColor: Colors.blue,
            itemStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            doneStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        showTitleActions: true,
        onChanged: (date) {
          print('change $date in time zone ' +
              date.timeZoneOffset.inHours.toString());
        },
        onConfirm: (date) {
          // setState(() {
          saatSET =date;
          _safaksayarUserViewModel.tarihVeSaatiBirlestir(tarihGET, saatGET);
          //});

          print('confirm $date');
        },
        currentTime: DateTime.now(),
        locale: LocaleGetir(myLocale),
      );
    }

    return new Scaffold(
        backgroundColor: Colors.black,
        appBar: new AppBar(
          title: Center(child: Text("Ayarlar v.1.0.3")),
          backgroundColor: Colors.white12,
          elevation: 1,
        ),
        body: new Column(
          children: <Widget>[
            // Divider(endIndent: 30,indent: 30,height: 10,color: Colors.white,),
            SizedBox(
              height: 24,
            ),


            FlatButton(

                onPressed: () {
                  _tarihiGoster(context);
                },
                child: Center(
                  child: Text(
                    "Tehris/Sayaç Tarihini Değiştir",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 18,
                    ),
                  ),
                )),
            Center(
              child: FlatButton(
                child: Text(
                  DateFormat('dd.MM.yyyy').format(tarihGET),
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                onPressed: () {
                  _tarihiGoster(context);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              endIndent: 30,
              indent: 30,
              height: 10,
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            FlatButton(
                onPressed: () {
                  _saatiGoster(context);
                },
                child: Text(
                  "Tehris/Sayaç Saatini Değiştir",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 18,
                  ),
                )),
            Center(
              child: FlatButton(
                child: Text(
                  DateFormat('kk:mm:ss').format(saatGET),
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                onPressed: () {
                  _saatiGoster(context);
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 5,
            ),
            /* Container(
              //color: Colors.white10,
              decoration: new BoxDecoration(
                color: Colors.white10,
                borderRadius: new BorderRadius.only(
                  bottomRight:const Radius.circular(19.0),
                  bottomLeft: const Radius.circular(19.0),
                  topLeft: const Radius.circular(19.0),
                  topRight: const Radius.circular(19.0),
                )
            ),
              child: FlatButton(
                  onPressed: () {
                    _bilgileriKaydet(_safaksayarUserViewModel);
                  },
                  child: Text(

                    " Kaydet ",
                    style: TextStyle(color: Colors.green,fontSize: 22,),
                  )),
            ),
*/
            Divider(
              endIndent: 30,
              indent: 30,
              height: 10,
              color: Colors.white,
            ),
            Column(
              children: <Widget>[
                Center(
                  child: FlatButton(
                    child: Text(
                      "www.hakankucuk.com",
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(

                  child: Text(
                    "  Önemli günlerinizin ne kadar süre sonra gerçekleşeceğini hesaplayan bu yazılımı "
                        "umarım beğenirsiniz. Yazılım hakkındaki görüşlerinizi yorumlara bekliyorum. "
                        "\n   Mutlu gününüze en kısa sürede kavuşmanız dileğimle.",
                    style: TextStyle(
                      fontSize: 14, color: Colors.yellow.shade300,wordSpacing: 3,letterSpacing:1,
                    ),

                  ),
                ),
                /* Container(
                  color: Colors.white,
                  child: Text("tarih:$tarih tarihString : $tarihString",style: TextStyle(fontSize: 22),),
                ),Container(
                  color: Colors.white,
                  child: Text("saat:$saat saatString : $saatString",style: TextStyle(fontSize: 22),),
                ),

                */
              ],
            ),
          ],
        ));
  }

  LocaleGetir(Locale myLocale) {
    var sonuc;
    LocaleType.values.forEach((element) {
      //print(element);
      String localst = element.toString();
      localst = element.toString().substring(11, localst.length).toString();

      // print("Aha Bu :"+myLocale.toString());
      // print("localSt :"+localst.toString());

      if (localst == myLocale.toString()) {
        sonuc = element;
        //  print("Element Gönderilecek");
        sonuc = element;
      } else {
        // print(localst+"="+myLocale.toString());
      }
    });
    // if (sonuc==null)
    return LocaleType.tr;
    // return sonuc;
  }
}

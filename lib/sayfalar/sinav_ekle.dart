import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/common_widget/social_log_in_button.dart';
import 'package:physiomarapp/modeller/user_examp.dart';
import 'package:physiomarapp/sayfalar/yardim_sayfasi.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class SinavEkle extends StatefulWidget {
  final UserExamp userExamp;

  SinavEkle({@required this.userExamp});

  @override
  _SinavEkleState createState() => _SinavEkleState();
}

class _SinavEkleState extends State<SinavEkle> {
  final _formKey = GlobalKey<FormState>();
  String gorev = "yeni";
  UserExamp _userExamp;
  String _sinavAdi;
  String _sohbetOdasi;
  DateTime _tarih;
  int _sira;
  String _hata;

  TimeOfDay _saat;
  TimeOfDay _picketSaat;

  @override
  void initState() {
    if (widget.userExamp != null) {
      gorev = "guncelle";
      _userExamp = widget.userExamp;
      _sinavAdi = _userExamp.exampbaslik;
      _sohbetOdasi = _userExamp.exampRoom;
      _tarih = DateTime.parse(_userExamp.examTarih);
      _sira = _userExamp.exampSira;
      _hata = null;
      _saat = TimeOfDay(hour: _tarih.hour, minute: _tarih.minute);
      _picketSaat = _saat;
      print("Gelen Examp nulldan farklı : " + widget.userExamp.toString());
    }
    super.initState();
  }

  void _formSubmit(BuildContext context, UserViewModel _userViewModel) async {
    if (_hataKonrol(context,_userViewModel)) {
      _hata = null;

      _tarih = DateTime(
          _tarih.year, _tarih.month, _tarih.day, _saat.hour, _saat.minute, 0);
      print("Kaydedilecek Tarihimiz : $_tarih");

      _formKey.currentState.save();
      final _userModel = Provider.of<UserViewModel>(context, listen: false);
      var _user = _userModel.userGET;
      try {
        print("Tarihim :" + _tarih.toString());
        if (_tarih == null) _tarih = DateTime.now();
        _userExamp = UserExamp(
            userID: _user.userID,
            exampbaslik: _sinavAdi,
            exampID: (_userExamp==null) ? null : _userExamp.exampID,
            exampRoom: _sohbetOdasi,
            exampSira: _sira,
            examTarih: _tarih.toString());
        print("Sorun Yok : " + _userExamp.toString());
        UserExamp sonuc;
        if (gorev == "yeni") {
          print("Görevimiz Yeni bir examp kaydetmek");
          sonuc = await _userModel.exampEkleDB(_userExamp);
        }

        if (gorev == "guncelle") {
          print("Görevimiz examp Güncellemek");
          sonuc = await _userModel.exampGuncelleDB(_userExamp);
        }

        if (sonuc == null) {
          _userModel.exampSET = sonuc;
          _hata =
          "Kayıt Sırasında Hata Oluştu. Girmiş olduğunuz verileri kontrol ediniz...";
        } else {
          print("hata yokki");
          _userModel.exampSET = sonuc;
          _hata = null;
          bool uyariSonuc = await PlatformDuyarliAlertDialog(
            icerik: (gorev == "yeni")
                ? _userViewModel.translate("sinaviniz_basarili_bir_sekilde_olusturuldu", context)
                : _userViewModel.translate("sinaviniz_basarili_bir_sekilde_guncellendi", context),
            anaButonYazisi: "Tamam",
            baslik: "Tamam",
          ).goster(context);

          if (uyariSonuc) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
      } catch (e) {
        print("Hatalar Oluştu : " + e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    initializeDateFormatting(myLocale.toString());
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    print("Sıra $_sira oda: $_sohbetOdasi");

    return Scaffold(
      appBar: AppBar(
        title: Text(_userViewModel.translate("sinav_islemleri", context)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _orneksinav(context,_userViewModel),
            _hata == null
                ? SizedBox(
              height: 1,
            )
                : Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 5, left: 30, right: 30),
              child: Text(
                _hata,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.2,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: Colors.white30,
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: Column(
                  children: <Widget>[
                    new ListTile(
                      leading: Icon(Icons.featured_play_list),
                      trailing: InkWell(child: Icon(Icons.help_outline),
                      onTap: (){
                        _yardimGoster("sinavAdi",context,_userViewModel);
                      },),
                      //subtitle: Text("Deneme"),
                      title: new TextFormField(
                        onSaved: (String sinavAdi) {
                          _sinavAdi = sinavAdi;
                        },
                        initialValue: _userExamp == null
                            ? ""
                            : _userExamp.exampbaslik.trim().toString(),
                        keyboardType: TextInputType.text,
                        maxLength: 23,
                        autofocus: false,
                        onChanged: (String sinavAdi) {
                          setState(() {
                            _sinavAdi = sinavAdi;
                          });
                          print("Sınav Adı : $sinavAdi");
                        },
                        decoration: new InputDecoration(
                          hintText: _userViewModel.translate("sinav_adi", context),
                        ),
                      ),
                    ),
                    new ListTile(
                      leading: const Icon(Icons.chat),
                      trailing: InkWell(child: Icon(Icons.help_outline),
                        onTap: (){
                          _yardimGoster("sohbetOdasi",context,_userViewModel);
                        },),
                      title: TextFormField(
                        onSaved: (String odaadi) {
                          _sohbetOdasi = odaadi;
                        },
                        initialValue: _userExamp == null
                            ? ""
                            : _userExamp.exampRoom.trim().toString(),
                        keyboardType: TextInputType.text,
                        maxLength: 20,
                        autofocus: false,
                        onChanged: (String sohbetOdaAdi) {
                          print("Sohbet Oda Adı : $sohbetOdaAdi");
                          setState(() {
                            _sohbetOdasi = sohbetOdaAdi;
                          });
                        },
                        decoration: new InputDecoration(
                          hintText: _userViewModel.translate("sohbet_oda_ismi", context),
                        ),
                      ),
                    ),
                    /*
                    ListTile(
                      leading: const Icon(Icons.apps),
                      trailing: InkWell(child: Icon(Icons.help_outline),
                        onTap: (){
                          _yardimGoster("gosterimSirasi",context,_userViewModel);
                        },),
                      title: TextFormField(
                        initialValue: _sira == null
                            ? ""
                            : _sira
                            .toString(), // == null ? "" : _sira.toString(),
                        //initialValue: _sira.toString(),
                        onSaved: (String gosterimSirasi) {
                          int sira = 0;
                          try {
                            sira = int.parse(gosterimSirasi);
                          } catch (e) {
                            sira = 0;
                          }

                          setState(() {
                            _sira = sira;
                          });
                          //  print("sonn");
                        },
                        keyboardType: TextInputType.number,
                        //maxLength: 25,
                        autofocus: false,
                        onChanged: (String gosterimSirasi2) {
                          int sira = 0;
                          try {
                            sira = int.parse(gosterimSirasi2);
                          } catch (e) {
                            sira = 0;
                          }
                          print("sonn : $sira");
                          setState(() {
                            _sira = sira;
                          });
                        },

                        decoration: new InputDecoration(
                          hintText: _userViewModel.translate("gosterim_sirasi", context),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                    ), */
                    new ListTile(
                      leading: const Icon(Icons.today),
                      title: Text(_userViewModel.translate("sinav_tarihi", context)),
                      subtitle: _tarihPicker(context,_userViewModel),
                    ),
                    ListTile(
                      leading: const Icon(Icons.today),
                      title:  Text(_userViewModel.translate("sinav_saati", context)),
                      subtitle: _saatPicker(context,_userViewModel),
                    ),
                    Container(
                      width: 250,
                      child: SocialLoginButton(
                        // textColor: Colors.orange,
                        butonText: (gorev == "yeni") ? _userViewModel.translate("kaydet", context) : _userViewModel.translate("guncelle", context),
                        butonIcon: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        onPressed: () => _formSubmit(context,_userViewModel),
                        butonColor: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _orneksinav(BuildContext context, UserViewModel _userViewModel) {
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
      height: 140,
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
                      child: Text(_userViewModel.translate("duzenle", context)), value: 'Doge'),
                  new PopupMenuItem<String>(
                      child: Text(_userViewModel.translate("sohbet", context)), value: 'Lion'),
                ],
              ),
              Container(
                child: Text(
                  _sinavAdi ?? _userViewModel.translate("sinav_adi", context),
                  style: TextStyle(fontSize: 22),
                ),
                margin: EdgeInsets.only(top: 10),
              ),
              Icon(Icons.delete_forever),
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
                      _tarihCevirToString(_tarih, context) +
                          " " +
                          _saatCevirToString(_saat, context),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ],
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
                    Text(_userViewModel.translate("oda", context) +" :"),
                    Text(
                      _sohbetOdasi == null ? _userViewModel.translate("genel", context) : _sohbetOdasi.trim(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.chat,
                        size: 24,
                        color: Colors.black,
                      ),
                      label: Text(_userViewModel.translate("sohbet", context)),
                      //color: Colors.green.shade100,
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 4),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _tarihCevirToString(DateTime tarih, BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    var dateFormat = new DateFormat.yMMMMd(myLocale.toString());
    try {
      if (_tarih != null) {
        // final df = new DateFormat('dd-MMM-yyyy');

        print("Gelen Tarih : $_tarih");
        print("Dönüşen Tarih : " + dateFormat.format(_tarih));
        return dateFormat.format(_tarih);
      }
    } catch (e) {
      print("_tarihCevirToString hata : " + e.toString());
    }
    return dateFormat.format(DateTime.now());
  }

  _saatCevirToString(TimeOfDay saat, BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    //var dateFormat = new DateFormat.yMMMMd(myLocale.toString());
    var timeFormat = new DateFormat.Hms(myLocale.toString());
    try {
      if (_saat != null) {
        print("Gelen Saat : $_saat");
        DateTime donusecekSaaat = DateTime.now();
        if (_tarih != null) {
          donusecekSaaat = DateTime(
              _tarih.year, _tarih.month, _tarih.day, _saat.hour, _saat.minute);
        } else
          donusecekSaaat = DateTime(donusecekSaaat.year, donusecekSaaat.month,
              donusecekSaaat.day, _saat.hour, _saat.minute);
        print("Dönüşen Saat : " + timeFormat.format(donusecekSaaat));
        //return timeFormat.format(_saat);
        return timeFormat.format(donusecekSaaat);
      }
    } catch (e) {
      print("_saatCevirToString hata : " + e.toString());
    }
    return "hata";
    return "hata";
  }

  bool _hataKonrol(BuildContext context, UserViewModel _userViewModel) {
    if (_sinavAdi == null || _sinavAdi.trim() == "") {
      setState(() {
        _hata = _userViewModel.translate("sinav_adiniz_yazmadiniz", context);
      });
      return false;
    }

    if (_sohbetOdasi == null || _sohbetOdasi.trim() == "") {
      setState(() {
        _hata = _userViewModel.translate("sohbet_oda_ismi_bos_gecilemez", context);
      });
      return false;
    }
    if (_saat == null || _tarih == null) {
      setState(() {
        _hata = _userViewModel.translate("tarih_veya_saat_hatali", context);
      });
      return false;
    }

    return true;
  }

  _tarihPicker(BuildContext context, UserViewModel _userViewModel) {
    Locale myLocale = Localizations.localeOf(context);
    print("My Locale Language Code Sınav Ekle : "+myLocale.languageCode.toString());
    if (_tarih == null && false) {
      return Text(_userViewModel.translate("sinav_tarihi_secmek_icin_tiklayin", context),

        style: TextStyle(color: Colors.blue),
      );
    }
    return InkWell(
      child: (_tarih == null)
          ? Text(
        _userViewModel.translate("sinav_tarihi_secmek_icin_tiklayin", context),
        style: TextStyle(color: Colors.blue),
      )
          : Text(_tarihCevirToString(_tarih, context)),
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
         // locale: Locale(myLocale.countryCode),
          firstDate: _tarih == null ? DateTime.now() : DateTime(_tarih.year),
          lastDate: DateTime(2022),
        ).then((secilenTarih) {
          setState(() {
            _tarih = secilenTarih;
          });
          print("Tarih Set state edildi :" +
              _tarih.toString() +
              " secilen tarih :" +
              secilenTarih.toString() +
              " saat : $_saat");
        });
        //print("Set State edildğinden dolayı burası çalışmadı...");
      },
    );
  }

  _saatPicker(BuildContext context, UserViewModel _userViewModel) {
//    print("Local Language :" + myLocale.languageCode);

    return InkWell(
      child: (_saat == null)
          ? Text(
        _userViewModel.translate("sinav_saati_secmek_icin_tiklayin", context),
        style: TextStyle(color: Colors.blue),
      )
          : Text(_saatCevirToString(_saat, context)),
      onTap: () {
        selectTime(context);
        //print("Set State edildğinden dolayı burası çalışmadı...");
      },
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    _picketSaat = await showTimePicker(

      context: context,
      initialTime: _saat ?? TimeOfDay.now(),
    );

    setState(() {
      _saat = _picketSaat;
    });
    print("Seçilen Saat : $_saat ");
  }

  void _yardimGoster(String yardimAdi, BuildContext context, UserViewModel _userViewModel) {
    if(yardimAdi=="sinavAdi")
      {
        String _icerik = _userViewModel.translate("yardim_sinav_adi", context);
        Navigator.of(context, rootNavigator: true)
            .push(CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => YardimSayfasi(baslik: _userViewModel.translate("yardim_sinav_adi_yardim", context), icerik:_icerik ),
        ));
      }
    if(yardimAdi=="gosterimSirasi")
    {
      String _icerik = _userViewModel.translate("yardim_gosterim_sirasi", context);
      Navigator.of(context, rootNavigator: true)
          .push(CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => YardimSayfasi(baslik: _userViewModel.translate("yardim_gosterim_sirasi_yardim", context), icerik:_icerik ),
      ));
    }
    if(yardimAdi=="sohbetOdasi")
    {
      String _icerik = _userViewModel.translate("yardim_sohbet_odasi", context);
      Navigator.of(context, rootNavigator: true)
          .push(CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => YardimSayfasi(baslik: _userViewModel.translate("yardim_sohbet_odasi_yardim", context), icerik:_icerik ),
      ));
    }

  }
}

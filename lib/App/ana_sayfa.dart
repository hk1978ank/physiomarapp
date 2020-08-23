import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/my_custom_bottom_common/my_custom_bottom_navi.dart';
import 'package:physiomarapp/my_custom_bottom_common/tab_items.dart';
import 'package:physiomarapp/sayfalar/prifil_sayfasi.dart';
import 'package:physiomarapp/sayfalar/qrkod_olustur.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  //bool kullaniciKontrolEdilsinmi;
  @override
  void initState() {
    //kullaniciKontrolEdilsinmi = true;
    print("Ana Sayfa Çalıştı");
  }

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.QrCode: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
   // TabItem.Ayarlar: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.QrCode: QRCodeOlustur(),
    //  TabItem.Sinavlar: Sinavlar(),
      TabItem.Profil: ProfilSayfasi(),
     // TabItem.Ayarlar: AyarlarSayfasi(),
    };
  }

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKey = {
    TabItem.QrCode: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
  //  TabItem.Ayarlar: GlobalKey<NavigatorState>(),
  };
  bool dboku = true;
  @override
  Widget build(BuildContext context) {
    //Mevcutta bir kullanıcı var mı kontrol edilecek...
   // print("Ana Sayfa Build $kullaniciKontrolEdilsinmi");

    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    TabItem _currentTab = TabItem.QrCode;
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async
      {
        //print("Seçili tabimiz 11222 :");
       var sorgu = await  PlatformDuyarliAlertDialog(
           icerik: _userViewModel.translate("uygulamayi_kaptmak_istiyormusunuz", context),
           baslik:_userViewModel.translate("uyari", context),
           anaButonYazisi: _userViewModel.translate("evet", context),
           iptalButonYazisi: _userViewModel.translate("hayir", context),
        ).goster(context);

       if(!sorgu) {
       //  print("çalıştı1");
         return !await navigatorKeys[_currentTab].currentState.maybePop();
       } else {
         print("çalıştı2");
         SystemNavigator.pop();
         //return await navigatorKeys[_currentTab].currentState.maybePop();
       }
      },

      child: MyCustomBottomNavigation(
        navigatorKeys: navigatorKey,
        sayfaOlusturucu: tumSayfalar(),
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
         // print("Seçili tabimiz 11 :"+secilenTab.toString());
          if (secilenTab == _currentTab) {
            //  print("nav key çalıştı");
            //dboku = true;
            try {
              //print("nacigattor 1:"+secilenTab.toString());
              navigatorKeys[secilenTab]
                  .currentState
                  .popUntil((route) => route.isFirst);
            } catch (e) {
              // dboku=true;
              print("Route Boş :" + e.toString());
            }
          } else {
            setState(() {
            //  print("Anasayfa onSelectedTab  :" + secilenTab.toString());
              _currentTab = secilenTab;
            });
          }
          setState(() {});
        },
      ),
    );

  }



}



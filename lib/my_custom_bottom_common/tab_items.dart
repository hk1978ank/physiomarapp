import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//enum TabItem {  Sinavim,Sinavlar,Sohbet,Profil,Ayarlar}
enum TabItem {QrCode,Profil}
class TabItemData {
  final String title;
  final IconData icon;
  TabItemData(this.title, this.icon);
  //UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

  static Map<TabItem, TabItemData> tumTablar = {
    //TabItem.SaymaSayfasi : TabItemData("sayac_menu", Icons.touch_app,),
    //TabItem.Sinavlarim : TabItemData("sinavlarim_menu", Icons.contact_mail,),
  //  TabItem.Sinavlar : TabItemData("sinavlar_menu", Icons.radio),
    TabItem.QrCode : TabItemData("sohbet_menu", Icons.chat),
    TabItem.Profil : TabItemData("profil_menu", Icons.account_circle),
    //TabItem.Ayarlar : TabItemData("Ayarlar", Icons.settings),
  };
}

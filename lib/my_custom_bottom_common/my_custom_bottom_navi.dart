import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:physiomarapp/my_custom_bottom_common/tab_items.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MyCustomBottomNavigation extends StatefulWidget {
  const MyCustomBottomNavigation({
    Key key,
    @required this.currentTab,
    @required this.onSelectedTab,
    @required this.sayfaOlusturucu,
    @required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlusturucu;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  _MyCustomBottomNavigationState createState() =>
      _MyCustomBottomNavigationState();
}

class _MyCustomBottomNavigationState extends State<MyCustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    //print("Cureent ============== Tabımız : "+widget.currentTab.toString());
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        //backgroundColor: widget.currentTab==TabItem.SaymaSayfasi ? Colors.black :
        //Colors.white.withOpacity(0.9),
        backgroundColor: Colors.black,
        iconSize: 32,
        activeColor: Colors.yellow,
        inactiveColor: Colors.grey,
      border: Border.all(width: 0.1),
        items: [
          _navItemOlustur(TabItem.QrCode,_userViewModel,context),
          _navItemOlustur(TabItem.Profil,_userViewModel,context),
        ],
        onTap: (index) => widget.onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(

            navigatorKey: widget.navigatorKeys[gosterilecekItem],
            builder: (context) {
              return widget.sayfaOlusturucu[gosterilecekItem];
            });
      },
    );
  }

  BottomNavigationBarItem _navItemOlustur(TabItem tabItem, UserViewModel _userViewModel, BuildContext context) {
    final olusturulacakTab = TabItemData.tumTablar[tabItem];
    //print("Gelennn :"+olusturulacakTab.title);
    String yeniTitle = _userViewModel.translate(olusturulacakTab.title, context);
   // print("Yeni Gelen Title :"+yeniTitle);
   // print("Oluşturulacak Tab :"+olusturulacakTab.title);
    //print("Current Tab================= :"+widget.currentTab.toString());
    return BottomNavigationBarItem(

      //backgroundColor: Colors.green,
      //activeIcon: Icon(olusturulacakTab.icon,color: Colors.red.shade100,),
      icon:Icon(olusturulacakTab.icon,size: 28,),
      title:  Text(
        yeniTitle,
          //olusturulacakTab.title,
        //_userViewModel.translate(olusturulacakTab.title, context),
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
      ),
    );
  }
}

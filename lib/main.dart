import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:physiomarapp/App/ana_sayfa.dart';
import 'package:physiomarapp/view_model/locatorSafakSayar.dart';
import 'package:provider/provider.dart';
import 'App/landing_page.dart';
import 'view_model/user_view_model.dart';

void main() {
  setupLocatorSafakSayar();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>(create:(context)=>UserViewModel(),),
       // ChangeNotifierProvider<SafaksayarUserViewModel>(create:(context)=>SafaksayarUserViewModel(),),
       // ChangeNotifierProvider<UserViewModel>(create:(context)=>UserViewModel(),),

      ],
      child: MaterialApp(
        localizationsDelegates: [
         // AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //AppLoca
        ],
        /*
        localeListResolutionCallback: (locale,supportedLocales)
        {
          for(var supportedLocale in supportedLocales)
          {
            print("Dil Dosyamız : "+locale.toString());
            //if(supportedLocale.languageCode==locale.languageCode && supportedLocale.countryCode == locale.countryCode)
            if(supportedLocale.languageCode == locale.toString())
              return supportedLocale;

        }
          return supportedLocales.first;

        }, */
        supportedLocales: [
           //Locale("en","US"),
           //Locale("tr","TR"),
           //Locale("de","DE"),

          //Locale("en"),
          Locale("tr"),
        //  Locale("de"),
         // Locale("ru"),
         // Locale("fr"),


        ],

        debugShowCheckedModeBanner: false,

       // title: "Kreş Otomasyon Yazılımı",
        theme: ThemeData(primarySwatch: Colors.blue,
          hintColor: Colors.black54,
        ),
        builder: (context, child) =>
            MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child),

        home: LandIngPage(),
      ),
    );
  }
}
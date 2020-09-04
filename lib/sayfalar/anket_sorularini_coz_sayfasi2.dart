import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:physiomarapp/common_widget/platform_duyarli_alert_dialog.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';
import 'package:physiomarapp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AnketSorulariniCoz2 extends StatefulWidget {
  @override
  _AnketSorulariniCoz2State createState() => _AnketSorulariniCoz2State();
}

class _AnketSorulariniCoz2State extends State<AnketSorulariniCoz2> {

  final _formKey = GlobalKey<FormState>();
  int soruid=0;
  int cevapid=0;
  String selectedRole = "Writer";
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: true);

    final List<CoolStep> steps2 = [
      CoolStep(
        title: "Basic Information",
        subtitle: "Please fill some of the basic information to get started",
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: "Name",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                controller: _nameCtrl,
              ),
              _buildTextField(
                labelText: "Email Address",
                validator: (value) {
                  if (value.isEmpty) {
                    return "Email address is required";
                  }
                  return null;
                },
                controller: _emailCtrl,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState.validate()) {
            return "Fill form correctly";
          }
          return null;
        },
      ),
      CoolStep(
        title: "Select your role",
        subtitle: "Choose a role that better defines you",
        content: Container(
          child: Row(
            children: <Widget>[
              _buildSelector(
                context: context,
                name: "Writer",
              ),
              SizedBox(width: 5.0),
              _buildSelector(
                context: context,
                name: "Editor",
              ),
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
    ];
    final List<CoolStep> steps = _anketSorulariniHazirla(_userViewModel.anketSorulariGET, _userViewModel,soruid,cevapid);

    final stepper = CoolStepper(

      onCompleted: () {
        print("Steps completed!");
      },
      steps: steps,
      config: CoolStepperConfig(

        backText: "Geri",
        nextText: "İleri",
        //icon: Icon(Icons.arrow_back),
        stepText: "Soru :",
        ofText: " Toplam :"
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
           _userViewModel.anketSorulariGET.data.anketAdi,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text(
              "Kaydet",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.transparent,
            focusColor: Colors.transparent,
            disabledColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onPressed: () {
              kontrolEt(context,_userViewModel);
            },
          ),
        ],
      ),
      body: Container(
          child: stepper,
        //child: stepper,
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_userViewModel.anketSorulariGET.data.aciklama,style: TextStyle(fontSize: 16,color: Colors.black),),
        ),
      ),
    );
  }

  Widget _buildTextField({
    String labelText,
    FormFieldValidator<String> validator,
    TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildSelector({
    BuildContext context,
    String name,
  }) {
    bool isActive = name == selectedRole;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedRole,
          onChanged: (String v) {
            setState(() {
              selectedRole = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  List<CoolStep> _anketSorulariniHazirla(

      AnketSorulariModelim anketSorulari, UserViewModel _userViewModel, int soruid, int cevapid,) {
    List<CoolStep> soruListem = new List<CoolStep>();
    soruid=0;
    anketSorulari.data.sorular.forEach((soru) {
      print("Buradayız2222..");
      var coolstep = CoolStep(
        title: "Soru",
        subtitle: soru.soru,
        content: _soruCevapla(soru, anketSorulari, _userViewModel,soruid),
        validation: () {
          return null;
        },
      );
      soruListem.add(coolstep);
      soruid++;
    });
    return soruListem;
  }

  _soruCevapla(Sorular soru, AnketSorulariModelim anketSorulari,
      UserViewModel userViewModel, int soruid) {
    return secenekleriGoster(soru, anketSorulari, userViewModel,soruid);
  }

  secenekleriGoster(Sorular soru, AnketSorulariModelim anketSorulari,
      UserViewModel userViewModel, int soruid) {
    var widgetListemSorular = new List<Widget>();
    print("Soru : " + soru.soru);

    var seneceklerimiz = soru.secenekler.toList();
    int secenekId = 0;
    seneceklerimiz.forEach((element) {
      print("--------------");
      print("SeçenekID Hakan :"+ secenekId.toString());
      print("Seçenek Soru :" + soru.soru);
      print("Seçenek Cevap :" + element.secenek.toString());
      Widget secenekgim;
      if (element.secim == null) {
        print("Seçenek Cevaplar :" + element.secim.toString());
        //print("Seçimimiz True Hakan");
        Widget secenek = FlatButton(
          //color: Colors.green,
          padding: EdgeInsets.all(8),
          //child: Text(soruid.toString()+"-"+secenekId.toString()+" "+element.secenek.toString()),
          child: Text(element.secenek.toString()),
          onPressed: () {
            print(secenekId.toString()+"Bu ne iş2");
            secenekDegistir(soru, anketSorulari, element, userViewModel,soruid,secenekId);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blue, width: 3.0),
          ),
        );
        secenekgim = secenek;
      } else {
        Widget secenek = FlatButton(
          color: Colors.blueAccent,
          padding: EdgeInsets.all(8),
          child: Text(element.secenek.toString()),
          onPressed: () {
            print(secenekId.toString()+"Bu ne iş2");
            secenekDegistir(soru, anketSorulari, element, userViewModel,soruid,secenekId);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blue, width: 3.0),
          ),
        );
        secenekgim = secenek;
      }
      secenekId++;
      widgetListemSorular.add(secenekgim);

    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgetListemSorular,
    );
  }

  void secenekDegistir(Sorular soru, AnketSorulariModelim anketSorulari,
      Secenekler element, UserViewModel userViewModel, int soruid,int secenekId) async {
    print("Soru : "+ soru.soru);
    print("Cevap : "+ element.secenek.toString());
    print(soruid.toString()+"-"+secenekId.toString()+" "+element.secenek.toString());
    try{
      //anketSorulari.data.sorular[soruid].secenekler[secenekId].secim="True";
      print(secenekId.toString());
      //var sorgu = anketSorulari.data.sorular[soruid].secenekler[secenekId].secim="True";
      var sorgu = anketSorulari.data.sorular[soruid].secenekler.toList();
      int idsi = 0;
      sorgu.forEach((element2) {
        if(element2.secenek==element.secenek)
          {
            print("Evet Eşit");
            anketSorulari.data.sorular[soruid].secenekler[idsi].secim= element2.secenek;
            userViewModel.anketSorulariSET = anketSorulari;
            //anketSorulari.data.sorular[soruid].secenekler[idsi]

          } else {
          print("Hayır Eşit Değil");
          anketSorulari.data.sorular[soruid].secenekler[idsi].secim= null;
          userViewModel.anketSorulariSET = anketSorulari;
          }
      idsi++;
      });
    } catch(e)
    {
      print("Hata oluşturtr : "+e.toString());
    }

setState(() {

});
  }

  void kontrolEt(BuildContext context, UserViewModel _userViewModel) async {
    var sorgu = _userViewModel.anketSorulariGET;
    bool herseyYolundami = false;
    sorgu.data.sorular.forEach((soru) {
      bool yolunda2 = false;
      soru.secenekler.forEach((secenek) {
        if(secenek.secim!=null)
          {
          yolunda2 = true;
          }
      });
      if(yolunda2==false) {
        herseyYolundami=true;
      }
    });
   if(herseyYolundami){
     var sonuc = PlatformDuyarliAlertDialog(
       anaButonYazisi: "Tamam",
       icerik: "Cevaplamdığınız sorularınız var.",
       baslik: "Dikkat",
     ).goster(context);
   } else {
     var sonuc = await PlatformDuyarliAlertDialog(
       anaButonYazisi: "Evet",
       iptalButonYazisi: "Hayır",
       icerik: "Anketiniz fizyoterapistinize gönderilecek. Bu işlemin geri dönüşü yoktur. Onaylıyormusunuz?",
       baslik: "Dikkat",
     ).goster(context);

       if(sonuc)
         {
           print("Burası Çalıştı2");
           var sorgu = await _userViewModel.writeAnketSorulari(context, _userViewModel.anketSorulariGET, _userViewModel.hastaGET);
           if(sorgu)
             {
               PlatformDuyarliAlertDialog(
                 baslik: "Kayıt İşlemi",
                 icerik: "Anketiniz başarılı şekilde fizyoterapistinize gönderildi.",
                 anaButonYazisi: "Tamam",

               ).goster(context).then((value) async {
                 print("Aha Bura Çalıştı");
                 await _userViewModel.readAnketSorulariWithHastsa(_userViewModel.hastaGET).then((value){
                   Future.delayed(const Duration(microseconds: 50), () => Navigator.pop(context));
                 });

               // print("Anketler Sayfasına Dönülecek");
               });
             } else
               {
                 PlatformDuyarliAlertDialog(
                   baslik: "Hata",
                   icerik: "Anketiniz gönderilemedi. Sistem hatası",
                   anaButonYazisi: "Tamam",

                 ).goster(context);
               }

           print("Gönder Gitsin");
         } else
           {
             print("Gönderme Düzeltecek...");
           }


   }
  }
}

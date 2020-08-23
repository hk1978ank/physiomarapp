import 'package:flutter/material.dart';
import 'package:physiomarapp/modeller/anket_sorulari_model.dart';

class HastaAnketCozSayfasi extends StatefulWidget {
  final AnketSorulariModelim anketSorulari;

  const HastaAnketCozSayfasi({Key key, this.anketSorulari}) : super(key: key);

  @override
  _HastaAnketCozSayfasiState createState() => _HastaAnketCozSayfasiState();
}

class _HastaAnketCozSayfasiState extends State<HastaAnketCozSayfasi> {

  int _aktifStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anket Çöz"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stepper(
          type: StepperType.vertical,
          physics: ClampingScrollPhysics(),
          onStepTapped: (seciliTab){
          },
          steps: _tumSteper(widget.anketSorulari),
          currentStep: _aktifStep,

        ),
      ),
    );
  }

  List<Step> _tumSteper(AnketSorulariModelim anketSorulari) {
    List<Step> stepListem = new List<Step>();
    anketSorulari.data.sorular.forEach((soru) {
      print("Buradayız..");
      var step = Step(
        title: Text(soru.soru),
        content: stepContentGetir(anketSorulari, soru),
      );
      stepListem.add(step);
    });
    return stepListem;
  }

  Widget stepContentGetir(AnketSorulariModelim anketSorulari, Sorular soru) {
    return Text("Deneme");
  }
}

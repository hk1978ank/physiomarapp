// To parse this JSON data, do
//
//     final hastaliklarModel = hastaliklarModelFromJson(jsonString);

import 'dart:convert';

List<HastaliklarModel> hastaliklarModelFromJson(String str) => List<HastaliklarModel>.from(json.decode(str).map((x) => HastaliklarModel.fromJson(x)));

String hastaliklarModelToJson(List<HastaliklarModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HastaliklarModel {
  HastaliklarModel({
    this.id,
    this.name,
    this.degerlendirme,
    this.tanim,
    this.anketler,
  });

  int id;
  String name;
  String degerlendirme;
  String tanim;
  bool secili;
  String doktorAciklama;
  List<Anketler> anketler;

  factory HastaliklarModel.fromJson(Map<String, dynamic> json) => HastaliklarModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    degerlendirme: json["degerlendirme"] == null ? null : json["degerlendirme"],
    tanim: json["tanim"] == null ? null : json["tanim"],
    anketler: json["anketler"] == null ? null : List<Anketler>.from(json["anketler"].map((x) => Anketler.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "degerlendirme": degerlendirme == null ? null : degerlendirme,
    "tanim": tanim == null ? null : tanim,
    "anketler": anketler == null ? null : List<dynamic>.from(anketler.map((x) => x.toJson())),
  };
}

class Anketler {
  Anketler({
    this.id,
    this.name,
    this.info,
  });

  int id;
  String name;
  String info;
  bool secili;
  String tarih;
  String hastaDoktorAciklama;

  factory Anketler.fromJson(Map<String, dynamic> json) => Anketler(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    info: json["info"] == null ? null : json["info"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "info": info == null ? null : info,
    "tarih": tarih == null ? DateTime.now().toString() : tarih,
    "hastaDoktorAciklama": hastaDoktorAciklama == null ? "" : hastaDoktorAciklama,

  };
}

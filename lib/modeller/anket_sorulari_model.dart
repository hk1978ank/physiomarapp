// To parse this JSON data, do
//
//     final anketSorulariModelim = anketSorulariModelimFromJson(jsonString);

import 'dart:convert';

AnketSorulariModelim anketSorulariModelimFromJson(String str) => AnketSorulariModelim.fromJson(json.decode(str));

String anketSorulariModelimToJson(AnketSorulariModelim data) => json.encode(data.toJson());

class AnketSorulariModelim {
  AnketSorulariModelim({
    this.data,
    this.cevaplamaTarihi,
    this.createDate,
    this.hastaDoktorAciklama,
    this.doktorID,
    this.docId,
  });

  Data data;
  String cevaplamaTarihi;
  String createDate;
  String doktorID;
  String docId;
  String hastaDoktorAciklama;

  factory AnketSorulariModelim.fromJson(Map<String, dynamic> json) => AnketSorulariModelim(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    cevaplamaTarihi: json["cevaplamaTarihi"] == null ? null : json["cevaplamaTarihi"],
    createDate: json["createDate"] == null ? "" : json["createDate"],
    doktorID: json["doktorID"] == null ? "" : json["doktorID"],
    hastaDoktorAciklama: json["hastaDoktorAciklama"] == null ? "" : json["hastaDoktorAciklama"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data.toJson(),
    "cevaplamaTarihi": cevaplamaTarihi == "" ? null : cevaplamaTarihi,
    "createDate": createDate == null ? "" : createDate,
    "doktorID": doktorID == null ? "" : doktorID,
    "hastaDoktorAciklama": hastaDoktorAciklama == null ? null : hastaDoktorAciklama,

  };
}

class Data {
  Data({
    this.id,
    this.anketAdi,
    this.aciklama,
    this.sorular,
  });

  int id;
  String anketAdi;
  String aciklama;
  List<Sorular> sorular;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    anketAdi: json["anket_adi"] == null ? null : json["anket_adi"],
    aciklama: json["aciklama"] == null ? null : json["aciklama"],
    sorular: json["sorular"] == null ? null : List<Sorular>.from(json["sorular"].map((x) => Sorular.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "anket_adi": anketAdi == null ? null : anketAdi,
    "aciklama": aciklama == null ? null : aciklama,
    "sorular": sorular == null ? null : List<dynamic>.from(sorular.map((x) => x.toJson())),
  };
}

class Sorular {
  Sorular({
    this.style,
    this.soru,
    this.konu,
    this.secenekler,
  });

  int style;
  String soru;
  String konu;
  List<Secenekler> secenekler;

  factory Sorular.fromJson(Map<String, dynamic> json) => Sorular(
    style: json["style"] == null ? null : json["style"],
    soru: json["soru"] == null ? null : json["soru"],
    konu: json["konu"] == null ? null : json["konu"],
    secenekler: json["secenekler"] == null ? null : List<Secenekler>.from(json["secenekler"].map((x) => Secenekler.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "style": style == null ? null : style,
    "soru": soru == null ? null : soru,
    "konu": konu == null ? null : konu,
    "secenekler": secenekler == null ? null : List<dynamic>.from(secenekler.map((x) => x.toJson())),
  };
}

class Secenekler {
  Secenekler({
    this.secenek,
    this.point,
    this.secim,
  });

  String secenek;
  int point;
  String secim;

  factory Secenekler.fromJson(Map<String, dynamic> json) => Secenekler(

    //secenek: json["secenek"] == null ? null : secenekValues.map[json["secenek"]],
    secenek: json["secenek"] == null ? null : json["secenek"],
    point: json["point"] == null ? null : json["point"],
    secim: json["secim"] == null ? null : json["secim"],
  );

  Map<String, dynamic> toJson() => {
    //"secenek": secenek == null ? null : secenekValues.reverse[secenek],
    "secenek": secenek == null ? null : secenek,
    "point": point == null ? null : point,
    "secim": secim == null ? null : secim,
  };
}

//enum Secenek { HIBIR_ZAMAN, NEREDEYSE_HIBIR_ZAMAN, BAZEN, OLDUKA_SK, OK_SK }
/*
final secenekValues = EnumValues({
  "Bazen": Secenek.BAZEN,
  "Hiçbir zaman": Secenek.HIBIR_ZAMAN,
  "Neredeyse hiçbir zaman": Secenek.NEREDEYSE_HIBIR_ZAMAN,
  "Çok sık": Secenek.OK_SK,
  "Oldukça sık": Secenek.OLDUKA_SK
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
*/
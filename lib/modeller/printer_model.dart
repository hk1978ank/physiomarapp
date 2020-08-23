// To parse this JSON data, do
//
//     final physiomarappModel = printerModelFromJson(jsonString);

import 'dart:convert';

PrinterModel printerModelFromJson(String str) => PrinterModel.fromJson(json.decode(str));

String printerModelToJson(PrinterModel data) => json.encode(data.toJson());

class PrinterModel {
  PrinterModel({
    this.name,
    this.port,
    this.cut,
    this.ip,
    this.data,
    this.feed,
  });

  String name;
  String port;
  bool cut;
  String ip;
  List<PrinterModelDatum> data;
  int feed;

  factory PrinterModel.fromJson(Map<String, dynamic> json) => PrinterModel(
    name: json["name"] == null ? null : json["name"],
    port: json["port"] == null ? null : json["port"],
    cut: json["cut"] == null ? null : json["cut"],
    ip: json["ip"] == null ? null : json["ip"],
    data: json["data"] == null ? null : List<PrinterModelDatum>.from(json["data"].map((x) => PrinterModelDatum.fromJson(x))),
    feed: json["feed"] == null ? null : json["feed"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "port": port == null ? null : port,
    "cut": cut == null ? null : cut,
    "ip": ip == null ? null : ip,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "feed": feed == null ? null : feed,
  };
}

class PrinterModelDatum {
  PrinterModelDatum({
    this.src,
    this.type,
    this.text,
    this.styles,
    this.data,
  });

  String src;
  String type;
  String text;
  FluffyStyles styles;
  List<DatumDatum> data;

  factory PrinterModelDatum.fromJson(Map<String, dynamic> json) => PrinterModelDatum(
    src: json["src"] == null ? null : json["src"],
    type: json["type"] == null ? null : json["type"],
    text: json["text"] == null ? null : json["text"],
    styles: json["styles"] == null ? null : FluffyStyles.fromJson(json["styles"]),
    data: json["data"] == null ? null : List<DatumDatum>.from(json["data"].map((x) => DatumDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "src": src == null ? null : src,
    "type": type == null ? null : type,
    "text": text == null ? null : text,
    "styles": styles == null ? null : styles.toJson(),
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DatumDatum {
  DatumDatum({
    this.center,
    this.text,
    this.styles,
  });

  bool center;
  String text;
  PurpleStyles styles;

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
    center: json["center"] == null ? null : json["center"],
    text: json["text"] == null ? null : json["text"],
    styles: json["styles"] == null ? null : PurpleStyles.fromJson(json["styles"]),
  );

  Map<String, dynamic> toJson() => {
    "center": center == null ? null : center,
    "text": text == null ? null : text,
    "styles": styles == null ? null : styles.toJson(),
  };
}

class PurpleStyles {
  PurpleStyles({
    this.aling,
    this.width,
    this.underline,
  });

  String aling;
  String width;
  bool underline;

  factory PurpleStyles.fromJson(Map<String, dynamic> json) => PurpleStyles(
    aling: json["aling"] == null ? null : json["aling"],
    width: json["width"] == null ? null : json["width"],
    underline: json["underline"] == null ? null : json["underline"],
  );

  Map<String, dynamic> toJson() => {
    "aling": aling == null ? null : aling,
    "width": width == null ? null : width,
    "underline": underline == null ? null : underline,
  };
}

class FluffyStyles {
  FluffyStyles({
    this.bold,
    this.underline,
    this.afterLines,
    this.reverse,
    this.aling,
  });

  bool bold;
  bool underline;
  int afterLines;
  bool reverse;
  String aling;

  factory FluffyStyles.fromJson(Map<String, dynamic> json) => FluffyStyles(
    bold: json["bold"] == null ? null : json["bold"],
    underline: json["underline"] == null ? null : json["underline"],
    afterLines: json["afterLines"] == null ? null : json["afterLines"],
    reverse: json["reverse"] == null ? null : json["reverse"],
    aling: json["aling"] == null ? null : json["aling"],
  );

  Map<String, dynamic> toJson() => {
    "bold": bold == null ? null : bold,
    "underline": underline == null ? null : underline,
    "afterLines": afterLines == null ? null : afterLines,
    "reverse": reverse == null ? null : reverse,
    "aling": aling == null ? null : aling,
  };
}

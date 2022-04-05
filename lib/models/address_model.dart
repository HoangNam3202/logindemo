// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

AddressModel addressModelFromJson(String str) =>
    AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  AddressModel({
    this.data,
    this.dataDate,
    this.generateDate,
    this.stats,
  });

  List<Datum>? data;
  String? dataDate;
  int? generateDate;
  Stats? stats;

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        dataDate: json["data_date"],
        generateDate: json["generate_date"],
        stats: Stats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "data_date": dataDate,
        "generate_date": generateDate,
        "stats": stats?.toJson(),
      };
}

class Datum {
  Datum({
    this.level1Id,
    this.name,
    this.type,
    this.level2S,
  });

  String? level1Id;
  String? name;
  DatumType? type;
  List<Level2>? level2S;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        level1Id: json["level1_id"],
        name: json["name"],
        type: datumTypeValues.map[json["type"]],
        level2S:
            List<Level2>.from(json["level2s"].map((x) => Level2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level1_id": level1Id,
        "name": name,
        "type": datumTypeValues.reverse?[type],
        "level2s": List<dynamic>.from(level2S!.map((x) => x.toJson())),
      };
}

class Level2 {
  Level2({
    this.level2Id,
    this.name,
    this.type,
    this.level3S,
  });

  String? level2Id;
  String? name;
  Level2Type? type;
  List<Level3>? level3S;

  factory Level2.fromJson(Map<String, dynamic> json) => Level2(
        level2Id: json["level2_id"],
        name: json["name"],
        type: level2TypeValues.map[json["type"]],
        level3S:
            List<Level3>.from(json["level3s"].map((x) => Level3.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "level2_id": level2Id,
        "name": name,
        "type": level2TypeValues.reverse?[type],
        "level3s": List<dynamic>.from(level3S!.map((x) => x.toJson())),
      };
}

class Level3 {
  Level3({
    this.level3Id,
    this.name,
    this.type,
  });

  String? level3Id;
  String? name;
  Level3Type? type;

  factory Level3.fromJson(Map<String, dynamic> json) => Level3(
        level3Id: json["level3_id"],
        name: json["name"],
        type: level3TypeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "level3_id": level3Id,
        "name": name,
        "type": level3TypeValues.reverse?[type],
      };
}

enum Level3Type { PHNG, TH_TRN, X }

final level3TypeValues = EnumValues({
  "Phường": Level3Type.PHNG,
  "Thị trấn": Level3Type.TH_TRN,
  "Xã": Level3Type.X
});

enum Level2Type { QUN, HUYN, TH_X, THNH_PH }

final level2TypeValues = EnumValues({
  "Huyện": Level2Type.HUYN,
  "Quận": Level2Type.QUN,
  "Thành phố": Level2Type.THNH_PH,
  "Thị xã": Level2Type.TH_X
});

enum DatumType { THNH_PH_TRUNG_NG, TNH }

final datumTypeValues = EnumValues({
  "Thành phố Trung ương": DatumType.THNH_PH_TRUNG_NG,
  "Tỉnh": DatumType.TNH
});

class Stats {
  Stats({
    this.elapsedTime,
    this.level1Count,
    this.level2Count,
    this.level3Count,
  });

  double? elapsedTime;
  int? level1Count;
  int? level2Count;
  int? level3Count;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        elapsedTime: json["elapsed_time"].toDouble(),
        level1Count: json["level1_count"],
        level2Count: json["level2_count"],
        level3Count: json["level3_count"],
      );

  Map<String, dynamic> toJson() => {
        "elapsed_time": elapsedTime,
        "level1_count": level1Count,
        "level2_count": level2Count,
        "level3_count": level3Count,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

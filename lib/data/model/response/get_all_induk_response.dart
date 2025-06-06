import 'dart:convert';

class GetInduk {
  final int id;
  final String noRing;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String jenisKenari;
  final String? keterangan;
  final String? gambarBurung;

  GetInduk({
    required this.id,
    required this.noRing,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.jenisKenari,
    required this.keterangan,
    required this.gambarBurung,
  });

  GetInduk copyWith({
    int? id,
    String? noRing,
    DateTime? tanggalLahir,
    String? jenisKelamin,
    String? jenisKenari,
    String? keterangan,
    String? gambarBurung,
  }) => GetInduk(
    id: id ?? this.id,
    noRing: noRing ?? this.noRing,
    tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    jenisKelamin: jenisKelamin ?? this.jenisKelamin,
    jenisKenari: jenisKenari ?? this.jenisKenari,
    keterangan: keterangan ?? this.keterangan,
    gambarBurung: gambarBurung ?? this.gambarBurung,
  );

  factory GetInduk.fromRawJson(String str) =>
      GetInduk.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetInduk.fromJson(Map<String, dynamic> json) => GetInduk(
    id: json["id"],
    noRing: json["no_ring"],
    tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    jenisKelamin: json["jenis_kelamin"],
    jenisKenari: json["jenis_kenari"],
    keterangan: json["keterangan"] ?? "",
    gambarBurung: json["gambar_burung"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "no_ring": noRing,
    "tanggal_lahir":
        "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    "jenis_kelamin": jenisKelamin,
    "jenis_kenari": jenisKenari,
    "keterangan": keterangan,
    "gambar_burung": gambarBurung,
  };
}

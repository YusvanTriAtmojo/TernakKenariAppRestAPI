import 'dart:convert';

class AdminProfile {
    final int? id;
    final String? name;

    AdminProfile({
        this.id,
        this.name,
    });

    factory AdminProfile.fromJson(String str) => AdminProfile.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AdminProfile.fromMap(Map<String, dynamic> json) => AdminProfile(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}

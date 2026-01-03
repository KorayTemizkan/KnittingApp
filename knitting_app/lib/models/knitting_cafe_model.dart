import 'package:flutter/material.dart';

class KnittingCafeModel {
  final int id;
  final String name;
  final String address;
  final String phone;
  final List<String> features; // sadece listelemek istediğimiz için list
  final Map<String, String> socialMedia;
  // Neden list değil? çünkü anahtar-değer ikilisi tutuyoruz. eşleştirme lazım

  KnittingCafeModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.features,
    required this.socialMedia,
  });

  /// JSON / Map → Model
  factory KnittingCafeModel.fromMap(Map<String, dynamic> map) {
    return KnittingCafeModel(
      id: map["id"] ?? 0,
      name: map["name"] ?? "",
      address: map["address"] ?? "",
      phone: map["phone"] ?? "",
      features: List<String>.from(map["features"] ?? []),
      socialMedia: Map<String, String>.from(map["socialMedia"] ?? {}),
    );
  }

  /// Model → JSON / Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "phone": phone,
      "features": features,
      "socialMedia": socialMedia,
    };
  }

  @override
  String toString() {
    return 'KnittingCafe{id: $id, name: $name, address: $address}';
  }
}

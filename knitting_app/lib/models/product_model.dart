import 'package:flutter/material.dart';

/* 
Örneğin bir ayıcık gibi düşün, bunun videosu olucak ama tanıtım videosu gibi düşün. baştan sona aşamalar olmayacak
*/
class ProductModel { 
  final int id;
  final String title;
  final String difficulty;
  final String estimatedHour;
  final List<String> colors;
  final String yarnType;   // ip türü
  final String hookSize;   // Tığ numarası
  final String imageUrl;
  // BURAYA URUN VIDEO LINKI EKLEYECEGIZ

  ProductModel({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.estimatedHour,
    required this.colors,
    required this.yarnType,
    required this.hookSize,
    required this.imageUrl,
  });

  /// JSON / Map → Model
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"] ?? 0,
      title: map["title"] ?? "",
      difficulty: map["difficulty"] ?? "",
      estimatedHour: map["estimatedHour"] ?? "",
      colors: List<String>.from(map["colors"] ?? []),
      yarnType: map["yarnType"] ?? "",
      hookSize: map["hookSize"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
    );
  }

  /// Model → JSON / Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "difficulty": difficulty,
      "estimatedHour": estimatedHour,
      "colors": colors,
      "yarnType": yarnType,
      "hookSize": hookSize,
      "imageUrl": imageUrl,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, title: $title, difficulty: $difficulty, estimatedHour: $estimatedHour}';
  }
}
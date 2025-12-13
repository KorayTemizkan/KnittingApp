import 'package:flutter/material.dart';

class HowToModel {
  final int id;
  final String title;
  final String difficulty;
  final String estimatedHour;
  final List<String> colors;
  final String yarnType; // ip türü
  final String hookSize; // Tığ numarası
  final String imageUrl;

  HowToModel({
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
  factory HowToModel.fromMap(Map<String, dynamic> map) {
    return HowToModel(
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
    return 'HowTo{id: $id, title: $title, difficulty: $difficulty, estimatedHour: $estimatedHour}';
  }
}

import 'package:flutter/material.dart';

class Note {
  final int id;
  String title;
  String note;
  final int time;
  final Image image;

  Note({
    required this.id,
    required this.title,
    required this.note,
    required this.time,
    required this.image,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'time': time,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, note: $note, time: $time, image: $image,}';
  }
}

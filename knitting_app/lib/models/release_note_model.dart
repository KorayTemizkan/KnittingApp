import 'package:knitting_app/models/searchable_model.dart';

class ReleaseNoteModel{
  final int id;
  final String version;
  final String date;
  final List<String> notes;

  ReleaseNoteModel({
    required this.id,
    required this.version,
    required this.date,
    required this.notes,
  });

  /// JSON / Map → Model
  factory ReleaseNoteModel.fromMap(Map<String, dynamic> map) {
    return ReleaseNoteModel(
      id: map["id"] ?? 0,
      version: map["version"] ?? "",
      date: map["date"] ?? "",
      notes: List<String>.from(map["notes"] ?? []),
    );
  }

  /// Model → JSON / Map
  Map<String, dynamic> toMap() {
    return {"id": id, "version": version, "date": date, "notes": notes};
  }

  @override
  String toString() {
    return 'ReleaseNoteModel{id: $id, version: $version, date: $date}';
  }
}

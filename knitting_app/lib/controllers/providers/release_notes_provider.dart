import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/release_note_model.dart';

class ReleaseNotesProvider extends ChangeNotifier {
  List<ReleaseNoteModel> _releasesNotes = [];
  bool _isLoading = false;

  List<ReleaseNoteModel> get releaseNotes => _releasesNotes;
  bool get isLoading => _isLoading;

  Future<void> loadReleaseNotes() async {
    _isLoading = true;
    notifyListeners();

    _releasesNotes = await fetchReleaseNotes();

    _isLoading = false;
    notifyListeners();
  }
}

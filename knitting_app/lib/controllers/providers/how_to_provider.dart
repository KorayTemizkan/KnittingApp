import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/how_to.dart';

class HowToProvider extends ChangeNotifier {
  List<HowToModel> _howTos = [];
  bool _isLoading = false;

  List<HowToModel> get howTos => _howTos;
  bool get isLoading => _isLoading;

  Future<void> loadHowTos() async {
    _isLoading = true;
    notifyListeners();

    _howTos = await fetchHowTos();

    _isLoading = false;
    notifyListeners();
  }
}

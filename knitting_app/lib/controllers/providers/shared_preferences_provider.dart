// UI ile ilgili bir sınıf olup veri yönetimini sağlar, AppPreferences kullanarak UI rebuild eder ve state yönetimi yapar

// SOLID ilkelerini unutma, Single Responsibility. Hem veri işlemlerini yapıp hem arayüz yönetimi olmazdı. AppPreferences UI bağlı değil ve sadece veri yönetimi yapıyor. Burası ise Apppreferences ve UI arasındaki köprü
import 'package:knitting_app/controllers/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final AppPreferences _preferences;

  SharedPreferencesProvider(this._preferences);

  int get streak => _preferences.streak;
  bool get darkTheme => _preferences.darkTheme;

  Future<void> toggleTheme() async {
    await _preferences.setDarkTheme(!darkTheme);
    notifyListeners();
  }

  Future<void> increaseStreak() async {
    await _preferences.setStreak(streak + 1);
    notifyListeners();
  }

  Future<void> finishSetLanguage(String value) async {
    await _preferences.setLanguage(value);
    notifyListeners();
  }

  Future<void> finishSetFirstOpening() async {
    await _preferences.setFirstOpening(false);
    notifyListeners();
  }

  Future<void> finishSetFirstOpenAfterUpdate() async {
    await _preferences.setFirstOpeningAfterUpdate(false);
    notifyListeners();
  }
  
  //********/

  Future<void> finishSaveCharacter(int characterId) async {
    await _preferences.saveCharacter(characterId);
    notifyListeners();
  }

  Future<void> finishRemoveCharacter(int characterId) async {
    await _preferences.removeCharacter(characterId);
    notifyListeners();
  }

  Future<List<String>> finishGetSavedCharacters() async {
    return await _preferences.getSavedCharacters();
  }
}

// BEĞENMELERİ EKLEMEMİŞİM
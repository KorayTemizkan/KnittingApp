import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  late SharedPreferences _preferences;
  final ImagePicker _picker = ImagePicker();

  /// Init
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // AÇILIŞ EKRANI
  static const String _firstOpenKey = 'firstOpen';
  static const String _knowledgeLevelKey = 'knowledgeLevelKey';
  static const String _languageKey = 'language';

  // ANA SAYFA
  static const String _streakKey = 'streak';

  // AYARLAR
  static const String _firstOpenAfterUpdateKey = 'firstOpenAfterUpdate';
  static const String _darkThemeKey = 'darkTheme';
  static const String _profilePhotoFilePathKey = 'profilePhotoFilePath';
  static const String _characterIdListKey = 'characterListKey';

  // UI için okuma
  int get streak => _preferences.getInt(_streakKey) ?? 0;
  bool get darkTheme => _preferences.getBool(_darkThemeKey) ?? false;
  bool get isFirstOpen => _preferences.getBool(_firstOpenKey) ?? true;
  String get profilePhoto => _preferences.getString(_profilePhotoFilePathKey) ?? '';

  // *****************************************************************************

  // AÇILIŞ EKRANI

  // İlk açılışı geçtiğimizi haber vermek
  Future<void> setFirstOpening() async {
    await _preferences.setBool(_firstOpenKey, false);
    notifyListeners();
  }

  // İlk açılış ekranında bilgi düzeyini ayarlamak, ileride eğitime göre bir üst düzeye çıkartabiliriz
  Future<void> setKnowledgeLevel(String value) async {
    await _preferences.setString(_knowledgeLevelKey, value);
    notifyListeners();
  }

  // Dili Türkçe-Azerbaycan Dili-İngilizce arasında değiştirmek
  Future<void> setLanguage(String value) async {
    await _preferences.setString(_languageKey, value);
    notifyListeners();
  }

  // *****************************************************************************

  // ANA SAYFA

  // Her gün streak'i 1 arttırmak
  Future<void> increaseStreak() async {
    await _preferences.setInt(_streakKey, streak + 1);
    notifyListeners();
  }

  // *****************************************************************************

  // GENEL AYARLAR

  // Koyu-Açık temalar arasında geçiş yapmak, mevcut temayı korumak
  Future<void> toggleTheme() async {
    await _preferences.setBool(_darkThemeKey, !darkTheme);
    notifyListeners();
  }
  
  // Güncelleme olduğunu haber vermek
  Future<void> setFirstOpeningAfterUpdate() async {
    await _preferences.setBool(_firstOpenAfterUpdateKey, false);
    notifyListeners();
  }

  // Profil fotoğrafını ayarlamak
  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image == null) return;

    await _preferences.setString(_profilePhotoFilePathKey, image.path);
    notifyListeners();
  }

  // *****************************************************************************

  // EĞİTİM ayarları

  List<String> get savedCharacters =>
      _preferences.getStringList(_characterIdListKey) ?? [];

  Future<void> saveCharacter(int characterId) async {
    final list = savedCharacters;
    list.add(characterId.toString());
    await _preferences.setStringList(_characterIdListKey, list);
    notifyListeners();
  }

  Future<void> removeCharacter(int characterId) async {
    final list = savedCharacters;
    list.remove(characterId.toString());
    await _preferences.setStringList(_characterIdListKey, list);
    notifyListeners();
  }
}

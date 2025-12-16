// SharedPreferences nedir? Telefonun diskindeki kalıcı ayarları yönetir, basit düzeyde saklama yapabilir

// Diskle doğrudan konuşur ve veri/okuma yazma işlemlerini asenkron yapar. UI veya başka bir katmanla ilgisi yoktur.

import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences
  _preferences; // başına _ koyarsan değişkenlerin private oluyor

  AppPreferences({required SharedPreferences preferences})
    : _preferences = preferences;

  // KEY
  static const String _streakKey = 'streak';
  static const String _firstOpenKey = 'firstOpen';
  static const String _firstOpenAfterUpdateKey = 'firstOpenAfterUpdate';
  static const String _darkThemeKey = 'darkTheme';
  static const String _languageKey = 'language';

  
  static const String _characterIdListKey = 'characterListKey';

  // READ
  int get streak =>
      _preferences.getInt(_streakKey) ??
      0; // diskte streak değişkeni var mı bakıyor, yoksa null dönüyor, ?? 0 ilk kurulumda default değer
  bool get darkTheme => _preferences.getBool(_darkThemeKey) ?? false;

  Future<void> setDarkTheme(bool value) async {
    await _preferences.setBool(_darkThemeKey, value);
  }

  // Future ve async yapısıyla bu fonksiyonun bitmesinin zaman alacağını Flutter'a bildiririz.
  Future<void> setStreak(int value) async {
    await _preferences.setInt(
      _streakKey,
      value,
    ); // yazma bitmeden alt satıra geçme ama UI da serbest olsun
  }

  Future<void> setLanguage(String value) async {
    await _preferences.setString(_languageKey, value);
  }

  Future<void> setFirstOpening(bool value) async {
    await _preferences.setBool(_firstOpenKey, value);
  }

  Future<void> setFirstOpeningAfterUpdate(bool value) async {
    await _preferences.setBool(_firstOpenAfterUpdateKey, value);
  }

  //********//

  Future<void> storeCharacters(List<String> characterList) async {
    await _preferences.setStringList(_characterIdListKey, characterList); // komple listeyi diske yazar, sharedpreferences doğası
  }

  Future<void> saveCharacter(int characterId) async {
    final characterIdList =
        _preferences.getStringList(_characterIdListKey) ?? []; // ilk açılışta yeni liste oluşur, buradan sonra her şeyi ramdeki maptan okuyoruz. performans kaybı yok
    characterIdList.add(characterId.toString());
    await storeCharacters(characterIdList);
  }

  Future<void> removeCharacter(int characterId) async {
    final characterIdList =
        _preferences.getStringList(_characterIdListKey) ?? [];
    characterIdList.remove(characterId.toString());
    await storeCharacters(characterIdList);
  }

  Future<List<String>> getSavedCharacters() async {
    final characterIdList =
        _preferences.getStringList(_characterIdListKey) ?? [];
    return characterIdList;
  }
}

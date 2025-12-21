import 'package:just_audio/just_audio.dart';

class MusicController {
  /* Singleton mantığı
  Ayna anda 2 müzik çalmayacak, her sayfada yeni player oluşmayacak, ayarlardan kapatınca her yerde kapanacak
 
  static: nesneye ait değil sınıfa ait , MusicController._instance gibi düşün. MusicController1. ile değil(yani sınıf ile erişiyoruz). her seferinde yeni controller oluşturmamaıza yardım ediyor
  
  final: bir kez oluşturulur ve değer atanır, sonra değiştirilemez
  _instance: gizli yaptık

  Bu yapı:

static → tek kopya

final → değiştirilemez

factory → kontrollü erişim

 En sağlam singleton kalıbı
  */

  static final MusicController _instance = MusicController.internal();
  factory MusicController() =>
      _instance; // factory constructor kullanarak yeni nesne oluşmaz, yani yeni nesne oluşturmaz varolanı verir. uygulamada bir yerde musiccontroller istediğimizde önceden oluşturulmuşu verir
  MusicController.internal(); // dışarıdan new edilemez hale getirebildik sonunda. sadece sınıf içinden oluşturabiliyoruz.

  final AudioPlayer _player = AudioPlayer(); // sınıftan nesne oluşturduk

  double _volume = 0.5;
  double get volume => _volume;

  // initialize kısaltması olarak bir yazılım geleneği
  Future<void> init() async {
    await _player.setAsset(
      'assets/musics/dreamy-lofi-music-no-copyright-375785.mp3',
    ); // dosyayı alıp belleğe alır
    _player.setLoopMode(LoopMode.one); // loop ayarını yapıyor
    _player.play();
  } // UI'dan bağımsız biçimde müzikçalarımızı ayarlardık

  // burada UI sadece servisle konuşuyor içeriğini bilmiyor
  void play() => _player.play();
  void pause() => _player.pause();

  void setVolume(double volume) {
    _volume = volume;
    _player.setVolume(volume);
  }

  /*
  Uygulama kapanırken playeri serbest bırakarak memory leak önler. bu fonksiyonu hep kullanmaya çalış
  */
  void dispose() {
    _player.dispose();
  }
}

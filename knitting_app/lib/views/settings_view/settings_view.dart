import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:knitting_app/controllers/settings/music_controller.dart';
import 'package:knitting_app/controllers/providers/theme_provider.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isPlaying = true;
  double volume = MusicController().volume;
  String selectedLanguage = 'TR';

  Future<void> _showMyDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Merhaba'),
          content: Text(
            'WhatsApp hattımıza yönlendiriliyorsunuz! Soru, öneri ve şikayetlerinizi bizlere iletebilirsiniz',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Geri dön'),
            ),
            TextButton(
              onPressed: () => openWhatsAppSupport(),
              child: const Text('Devam et'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Ayarlar'),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                /*
                AÇIK/KOYU TEMA
                BİZ KİMİZ? + Fidan ve beni tanıtan görsellerle ve YT videosuyla süslenmiş bir sayfa
                GÜNCELLEME NOTLARI
                BİZE SOR + Burada explore sayfasındaki fonksiyonun aynısını ekliyoruz WP DESTEK HATTI YANİ
                GİRİŞ YAP, KAYDOL, HESABIMI SİL
                SIK SORULAN SORULAR
                GİZLİLİK POLİTİKASI, KULLANIM KOŞULLARI
                DİL SEÇİMİ YAP + Şİmdilik sadece Türkçe
                BİZİ PUANLA ile play store sayfa linkimize gidiyoruz
                MÜZİK KONTROLCÜSÜ
                */
                /*
                ElevatedButton(
                  onPressed: () {
                    context.read<NotesProvider>().deleteDatabaseFile();
                  },
                  child: Text('Veritabanını sil'),
                ),
                */
                ListTile(
                  title: const Text('Koyu Tema'),
                  trailing: Switch(
                    value: context.watch<ThemeProvider>().isDark,
                    onChanged: (value) {
                      context.read<ThemeProvider>().toggleTheme(value);
                    },
                  ),
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Biz kimiz?'),
                  onTap: () {
                    context.push('/settings/aboutUs');
                  },
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Güncelleme Notları'),
                  onTap: () {
                    context.push('/settings/releaseNotes');
                  },
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Bize sor!'),
                  onTap: () {
                    _showMyDialog();
                  },
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Giriş yap!'),
                  onTap: () {
                    context.push('/settings/signIn');
                  },
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Kaydol'),
                  onTap: () {
                    context.push('/settings/register');
                  },
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Gizlilik Politikası'),
                  onTap: () {
                    context.go('/settings/privacyPolicy');
                  },
                ),

                ListTile(
                  title: const Text('Kullanım Koşulları'),
                  onTap: () {
                    context.go('/settings/termsOfUse');
                  },
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Dil seçimi yap'),
                  trailing: DropdownButton<String>(
                    value: selectedLanguage,
                    items: const [
                      DropdownMenuItem(
                        value: 'TR',
                        child: Text('Türkçe (Şimdilik tek dil!)'),
                      ),
                      DropdownMenuItem(
                        value: 'AZ',
                        child: Text('Azerbaycan Dili (Yakında!)'),
                      ),
                      DropdownMenuItem(
                        value: 'AZ',
                        child: Text('İngilizce (Yakında!)'),
                      ),
                    ],

                    onChanged: (value) {
                      setState(() {
                        // ekranı yeniden çizdirir, sürekli hatırlatmaktan yoruldum
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ),

                Divider(height: 5),

                ListTile(
                  title: const Text('Bizi puanla!'),
                  // bu açılan sayfada google play store ve youtube kanallarına yönlendirme olucak
                  onTap: () => openYoutubeVideo(
                    '5P7Fem6SvZE',
                  ), // ()=> Kullanıcı tıkladıktan sonra bu fonksiyonu çalıştır demektir
                ),

                Divider(height: 5),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isPlaying) {
                            MusicController().pause();
                          } else {
                            MusicController().play();
                          }
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: Icon(
                        _isPlaying
                            ? Icons.pause
                            : Icons.play_arrow, // doğruysa pause göster
                      ),
                    ),

                    const SizedBox(width: 8),
                    const Text('Music Controller'),
                  ],
                ),

                Slider(
                  value: volume,
                  onChanged: (value) {
                    setState(() {
                      volume = value;
                      MusicController().setVolume(value);
                    });
                  },
                ),

                // Bak ilginç bir şey öğrendim, exit(0) önerilmiyormuş. Uygulamadan aşağıya atıp bellekten de kapatınca işletim
                // sistemi otomatik ayarlıyormuş bellek yönetimini vs. haberin olsun. EXİT butonu yapmıyorum
              ],
            ),
          ),
        ],
      ),
    );
  }
}

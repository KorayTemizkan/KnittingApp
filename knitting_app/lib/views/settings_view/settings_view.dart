import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/settings/music_controller.dart';
import 'package:knitting_app/controllers/providers/theme_provider.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:knitting_app/views/settings_view/about_us_view.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Knitting App - Ayarlar'),

      body: Column(
        children: [
          Text('giris yap / kayit ol'),
    
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Dark Theme'),
                  trailing: Switch(
                    value: context.watch<ThemeProvider>().isDark,
                    onChanged: (value) {
                      context.read<ThemeProvider>().toggleTheme(value);
                    },
                  ),
                ),

                ListTile(
                  title: const Text('Biz kimiz?'),
                  onTap: () {
                    context.go('/settings/aboutUs');
                  },
                ),

                ListTile(
                  title: const Text('Bize sor!'),
                  onTap: () {
                    context.go('/settings/sendUs');
                  },
                ),

                ListTile(
                  title: const Text('Dil secimi yap'),
                  trailing: DropdownButton<String>(
                    value: selectedLanguage,
                    items: const [
                      DropdownMenuItem(value: 'TR', child: Text('Türkçe')),
                      DropdownMenuItem(value: 'AZ', child: Text('Azerbaycan Dili')),
                    ],

                    onChanged: (value) {
                      setState(() { // ekranı yeniden çizdirir, sürekli hatırlatmaktan yoruldum
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: const Text('Bizi puanla!'),
                  // bu açılan sayfada google play store ve youtube kanallarına yönlendirme olucak
                  onTap: () => openYoutubeVideo(
                    '5P7Fem6SvZE',
                  ), // ()=> Kullanıcı tıkladıktan sonra bu fonksiyonu çalıştır demektir
                ),

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

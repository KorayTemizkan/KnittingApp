import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/settings/music_controller.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/my_gesture_button.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';

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

      body: ListView(
        children: [
          // --- Hesap Bölümü ---
          TitleText(text: 'Hesap'), // Başlık eksikti, eklendi
          CardList(
            widgets: [
              MyGestureButton(
                route: 'signIn',
                text: 'Giriş Yap',
                icon: Icons.login,
              ), // İkon güncellendi
              MyGestureButton(
                route: 'register',
                text: 'Hesap Oluştur',
                icon: Icons.person_add,
              ),
              MyGestureButton(
                route: 'signOut',
                text: 'Çıkış Yap',
                icon: Icons.logout,
              ),
              MyGestureButton(
                route: 'deleteAccount',
                text: 'Hesabımı Sil',
                icon: Icons.delete_forever,
              ),
            ],
          ),

          // --- Uygulama Bölümü ---
          TitleText(text: 'Uygulama'),
          CardList(
            widgets: [
              MyGestureButton(
                route: 'theme',
                text: 'Tema Değiştir',
                icon: Icons.palette_outlined,
              ), // Renk paleti tığ işi için şıktır
              MyGestureButton(
                route: 'language',
                text: 'Dil Seçimi',
                icon: Icons.language,
              ),
              MyGestureButton(
                route: 'notifications',
                text: 'Bildirim Ayarları',
                icon: Icons.notifications_none,
              ), // EKSİK: Bildirimler
              MyGestureButton(
                route: 'music',
                text: 'Müzik ve Ses',
                icon: Icons.music_note,
              ),
            ],
          ),

          // --- İletişim & Destek Bölümü ---
          TitleText(text: 'İletişim & Destek'),
          CardList(
            widgets: [
              MyGestureButton(
                route: 'aboutUs',
                text: 'Biz Kimiz?',
                icon: Icons.info_outline,
              ),
              MyGestureButton(
                route: 'askUs',
                text: 'Sıkça Sorulan Sorular',
                icon: Icons.help_outline,
              ), // EKSİK: SSS
              MyGestureButton(
                route: 'contact',
                text: 'Bize Ulaşın',
                icon: Icons.mail_outline,
              ), // EKSİK: Doğrudan iletişim
              MyGestureButton(
                route: 'releaseNotes',
                text: 'Güncelleme Notları',
                icon: Icons.update,
              ),
            ],
          ),

          // --- Yasal Bölümü ---
          TitleText(text: 'Yasal'),
          CardList(
            widgets: [
              MyGestureButton(
                route: 'privacyPolicy',
                text: 'Gizlilik Politikası',
                icon: Icons.privacy_tip_outlined,
              ), // Daha standart isim
              
              MyGestureButton(
                route: 'termsOfUse',
                text: 'Kullanım Koşulları',
                icon: Icons.rule,
              ),
              MyGestureButton(
                route: 'licenses',
                text: 'Lisanslar',
                icon: Icons.card_membership,
              ), // EKSİK: Flutter uygulamalarında olması gerekir
            ],
          ),
          
          SizedBox(height: 15),
          /*
              myGestureDetector('/settings/signIn', 'Giriş Yap', Icons.person_add),
              InkWell(
                onTap: () => context.go('/settings/register'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.person_add, color: Color(0xFFFF5722)),
                  text: 'Hesap Oluştur',
                ),
              ),
              InkWell(
                onTap: () => context.go('/settings/signOut'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.logout, color: Color(0xFFFF5722)),
                  text: 'Çıkış Yap',
                ),
              ),
              InkWell(
                onTap: () => context.go('/settings/deleteAccount'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.delete_forever, color: Color(0xFFFF5722)),
                  text: 'Hesabımı Sil',
                ),
              ),
            ],
          ),

          TitleText(text: 'Uygulama'),

          CardList(
            widgets: [
              InkWell(
                onTap: () {
                  context.read<ThemeProvider>().toggleTheme(
                    !context.read<ThemeProvider>().isDark,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.dark_mode, color: Color(0xFFFF5722)),
                  text: 'Koyu Tema',
                ),
              ),
              InkWell(
                onTap: () {
                  // Buraya dil seçimi dialog veya sayfa
                },
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.language, color: Color(0xFFFF5722)),
                  text: 'Dil Seç',
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_isPlaying) {
                      MusicController().pause();
                    } else {
                      MusicController().play();
                    }
                    _isPlaying = !_isPlaying;
                  });
                },
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.music_note, color: Color(0xFFFF5722)),
                  text: 'Müzik',
                ),
              ),
            ],
          ),

          TitleText(text: 'İletişim'),

          CardList(
            widgets: [
              InkWell(
                onTap: () => context.go('/settings/aboutUs'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.info_outline, color: Color(0xFFFF5722)),
                  text: 'Biz Kimiz?',
                ),
              ),
              InkWell(
                onTap: () => _showMyDialog(),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(
                    Icons.question_answer_outlined,
                    color: Color(0xFFFF5722),
                  ),
                  text: 'Bize Sor',
                ),
              ),
              InkWell(
                onTap: () => context.go('/settings/releaseNotes'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.update, color: Color(0xFFFF5722)),
                  text: 'Güncelleme Notları',
                ),
              ),
            ],
          ),

          TitleText(text: 'Yasal'),

          CardList(
            widgets: [
              InkWell(
                onTap: () => context.go('/settings/privacyPolicy'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.article_outlined, color: Color(0xFFFF5722)),
                  text: 'Aydınlatma Metni',
                ),
              ),
              InkWell(
                onTap: () => context.go('/settings/termsOfUse'),
                borderRadius: BorderRadius.circular(16),
                child: InfoCard(
                  icon: Icon(Icons.rule, color: Color(0xFFFF5722)),
                  text: 'Kullanım Koşulları',
                ),
              ),
            ],
          ),

          SizedBox(height: 15),
          */
          /*

          Expanded(
            child: ListView(
              children: [
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

                Divider(height: 5),

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
          */
        ],
      ),
    );
  }
}

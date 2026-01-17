/* 17.01.2025, 18.56

Profil verilerini shared_preferences ile çekme ve düzenlemeyi ekle.
database için tabloları draw.io'ya aktar
Ayarlara iki kere tıklayınca iki kere gitmiş gibi oluyor. Onu düzelt.
Topluluk kısmında tüm kullanıcıları çekmeyi ekle.
İnternet var mı kontrolü ekle; yoksa veriler yerel json'dan çekilsin, varsa internetten
Devam et seçeneği olması lazım. Tarifin, örgünün veya ödevin yapmaya devam et seçeneği olmalı
Giriş ekranı için logo ekle ??
Hatırlatıcılar (Üç gündür bizimle değilsin, yeni yarışma var vb..)
ThemeProvider ile SharedPreferencesProvider birleştir


Uygulamada Anlık Takip İçin:

1) Ne kadar süre harcadım?

Bu projeyi bitirmek için 6 saat ayırdın
Son 7 günde tüm kullanıcıların %30'undan fazla örgü yaptın
Haftalık rapor

---------------------------------------------------

2) Kaç ödev yaptın?

İlerleme barı

---------------------------------------------------

3) Streak

X gündür uygulamayı aralıksız kullanıyorsun
Eğer streaki bozarsa telafi seçeneği ekle

---------------------------------------------------

4) Haftanın yarışması

Bu haftanın eğitici ödevi bebek patiği yapmak
Bu haftanın topluluk ödevi en güzel şapkayı örmek
( kullanıcılar beğenecek filan sayı artacak en çok beğenilen filan, rozet hediyeli )

---------------------------------------------------

5) Puanlama sistemi

Her biri tığcık(xp) olarak geri dönecek

Bir ödevi bitir
Bir eğitimi bitir
Bir projeyi kaydet
Bir projeyi beğen
Bir projeyi kaydedilenlerden gör
Bir projeyi beğenilenlerden gör
Bir gönderi yayınla
Bir gönderi beğen

*/

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/providers/ai_answers_provider.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/release_notes_provider.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/controllers/providers/theme_provider.dart';
import 'package:knitting_app/controllers/router.dart';
//import 'package:knitting_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Firebase ayarlamaları burada yapılır. Ancak Supabase için kapattım. Firebase kullanmayacağım.
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final supabaseUrl = dotenv
      .env['SUPABASE_URL']!; // buraya koyulan ! null olmayacağını garantiler
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  final spProvider = SharedPreferencesProvider();
  await spProvider.init();

  /*
Shared preferences diskten her çağrıda okuma yapmaz, uygulama açılırken diskteki XML/JSON dosyasını bir kere okur
Belleğe yükler
prefs.getStringList(...) gibi çağrılar yaptığında bellekteki Map'ten okur (O(1))

*/
  //final musicController = MusicController();
  // await musicController.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: spProvider),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HowToProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()..init()),
        ChangeNotifierProvider(create: (_) => KnittingCafeProvider()),
        ChangeNotifierProvider(create: (_) => AiAnswersProvider()..init()),
        ChangeNotifierProvider(create: (_) => SupabaseProvider()),
        ChangeNotifierProvider(create: (_) => ReleaseNotesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ProductProvider>()
          .loadProducts(); // widget ağacı oluşturulduğunda sadece tek bir kere verileri internetten çekiyoruz ve yetiyor

      context.read<HowToProvider>().loadHowTos();
      context.read<KnittingCafeProvider>().loadKnittingCafes();
      context
          .read<ReleaseNotesProvider>()
          .loadReleaseNotes(); // eğer internet bağlantısı yoksa? burayı kontrol et ileride Koray
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      // Dart'da named parameter = ile değil : ile verilir.
      routerConfig: router,

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,

      debugShowCheckedModeBanner: true,
    );
  }
}

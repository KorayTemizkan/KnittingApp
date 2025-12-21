import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/music_controller.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/theme_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/shared_preferences.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*
Shared preferences diskten her çağrıda okuma yapmaz, uygulama açılırken diskteki XML/JSON dosyasını bir kere okur
Belleğe yükler
prefs.getStringList(...) gibi çağrılar yaptığında bellekteki Map'ten okur (O(1))

*/
  // dikkat ! uı tarafına daha entegre etmedik
  final sp =
      await SharedPreferences.getInstance(); //sharedpreferences sınıfından katman oluşturma
  final appPreferences = AppPreferences(
    preferences: sp,
  ); // kalıcı veri katmanı oluşturduk

  final musicController = MusicController();
  await musicController.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
          create: (_) => SharedPreferencesProvider(appPreferences),
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      context
          .read<ProductProvider>()
          .loadProducts(); // widget ağacı oluşturulduğunda sadece tek bir kere verileri internetten çekiyoruz ve yetiyor
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

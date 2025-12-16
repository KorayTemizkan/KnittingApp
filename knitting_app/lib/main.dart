import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/shared_preferences.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

/*
Shared preferences diskten her çağrıda okuma yapmaz, uygulama açılırken diskteki XML/JSON dosyasını bir kere okur
Belleğe yükler
prefs.getStringList(...) gibi çağrılar yaptığında bellekteki Map'ten okur (O(1))

*/
// dikkat ! uı tarafına daha entegre etmedik
  final sp = await SharedPreferences.getInstance(); //sharedpreferences sınıfından katman oluşturma
  final appPreferences = AppPreferences(preferences: sp); // kalıcı veri katmanı oluşturduk

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => SharedPreferencesProvider(appPreferences)),
        ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/router.dart';
import 'package:provider/provider.dart';

class FirstOpenView extends StatefulWidget {
  const FirstOpenView({super.key});

  @override
  State<FirstOpenView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<FirstOpenView> {
  String selectedKnowledgeLevel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),

          Expanded(
            child: ListView(
              /*
              HOŞ GELDİNİZ KARŞILAMASI, KISA BİR TANITIM
              Uygulamaya girerken terms of use ve gizlilik şartlarını kabul edersiniz
              BİLGİ DÜZEYİNİZ
              KAYDOL
              GİRİŞ YAP
              DOĞRUCA UYGULAMAYA GİR
              */
              children: [
                Text(
                  'HOŞ GELDİNİZ! 30 Saniyenizi alarak sizlere en uygun algoritmayı oluşturabiliriz!',
                ),
                
                ListTile(
                  title: const Text('Bilgi düzeyin nedir?'),
                  trailing: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        value: 'beginner',
                        child: Text('Başlangıç'),
                        enabled: true,
                      ),
                      DropdownMenuItem(
                        value: 'intermediate',
                        child: Text('Orta'),
                      ),
                      DropdownMenuItem(value: 'advanced', child: Text('İleri')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedKnowledgeLevel = value!;
                      });
                    },
                  ),
                ),

                Divider(height: 5),

                Text(
                  'KAYIT OLMAK İSTER MİSİNİZ? Verilerinizi kaybetmemek ve farklı cihazdan giriş yaparken sorun yaşamamak için kaydolun!',
                ),

                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SharedPreferencesProvider>()
                        .setFirstOpening();
                    context.push('/settings/register');
                  },
                  child: const Text("Kaydol!"),
                ),

                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SharedPreferencesProvider>()
                        .setFirstOpening();
                    context.push('/settings/signIn');
                  },
                  child: const Text("Zaten hesabın mı var? Giriş yap!"),
                ),

                Divider(height: 5),

                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SharedPreferencesProvider>()
                        .setFirstOpening();
                    context.push(AppRoutes.feed);
                  },
                  child: const Text("Doğruca uygulamaya giriş yap!"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Knitting App - Ayarlar'),

      body: Column(
        children: [

          Text('settings_view'),
          Text('giris yap / kayit ol'),
          Text('ses ayarlari'),
          ListTile(
            title: const Text('Dark Theme'),
            trailing: Switch(value: false, onChanged: (v) {}),
          ),
          Text('Language'),
          Text('hakkimizda'),
          Text('bize yazin'),
          Text('bizi puanlayın'),
          Text('uygulamadan cikis yap'),
        ],
      ),
    );
  }
}

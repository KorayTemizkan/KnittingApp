import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _SearchViewState();
}

class _SearchViewState extends State<ExploreView> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final howToProvider = Provider.of<HowToProvider>(context);
    final howTos = howToProvider.howTos;

    return Scaffold(
      appBar: AppBarWidget(title: 'Keşfet'),
      body: Center(
        child: Column(
          children: [
            Text('ARAMA KISMINI WIDGET YAP VE ORTAK KULLANIMA AÇ, PRODUCTS İÇİN DE YANİ'),
            Text('SQFLİTE İLE YEREL DEPOLAMA VE FİREBASE İLE YEDEKLEME YAP'),

            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Mesaj',
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                openWhatsAppSupport(message: messageController.text);
              },
              child: Text('Fidan Öğretmen\'imize sor'),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: howTos.length,
                itemBuilder: (context, index) {
                  final h = howTos[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/howTo', extra: h);
                      },

                      leading: Image.network(
                        h.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      title: Text(h.title),
                      subtitle: Text("${h.difficulty}, ${h.estimatedHour}"),
                    ),
                  );
                },
              ),
            ),

            Text(
              'Yapay Zeka\'ya sor bölümümüzü geliştiriyoruz!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

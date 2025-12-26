import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _SearchViewState();
}

class _SearchViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    final howToProvider = Provider.of<HowToProvider>(context);
    final howTos = howToProvider.howTos;

    return Scaffold(
      appBar: AppBarWidget(title: 'Keşfet'),
      body: Center(
        child: Column(
          children: [
            Text('Temel örgü teknikleri'), // HowTos diye modelimiz bu
            Text('ARAMA KISMINI WIDGET YAP VE ORTAK KULLANIMA AÇ'),

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
              'Fidan Öğretmenimizden rehberler',
            ), // Guides diye modelimiz var
            Text('Odevler'), // Products'dan hallederiz
            Text('Fidan öğretmenimize sor'), //
            Text('Yapay zekaya sor'), //
          ],
        ),
      ),
    );
  }
}

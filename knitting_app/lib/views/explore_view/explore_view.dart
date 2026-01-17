import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/models/how_to_model.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _SearchViewState();
}

class _SearchViewState extends State<ExploreView> {
  final TextEditingController messageController = TextEditingController();

  Future<void> _showMyDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Merhaba'),
          content: Text(
            'WhatsApp hattımıza yönlendiriliyorsunuz! Fidan Öğretmen-e fotoğraf ya da fotoğrafsız soru sorabilirsiniz',
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
    final howTos = context.watch<HowToProvider>().howTos;
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBarWidget(title: 'Keşfet'),
      body: Center(
        child: Column(
          children: [
            // 4 UNSUR OLUCAK
            // ARAMA KISMI
            // PRODUCTS ( Yana kaydırmalık(hepsi listelenebilir ama 10 tanede 10 tane çekelim) + Tümünü göster diyip ayrı bir sayfaya da atabiliriz)
            // HOWTOS ( Yana kaydırmalık + Yukarıdakinin aynısı)
            // ARAÇLAR ( 4'lü grid olsun , Yapay zekaya sor, WP üzerinden bize yaz, Not al, SSS)
            GenericSearchAnchorBar<Searchable>(
              items: [...products, ...howTos],
              hintText: 'Ara...',
              onItemSelected: (item) {
                if (item is ProductModel) {
                  context.go('/products', extra: item);
                } else if (item is HowToModel) {
                  context.go('/howTo', extra: item);
                }
              },
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('PRODUCTS'),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/product', extra: p);
                      },

                      leading: Image.network(
                        p.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),

                      title: Text(p.title),
                      subtitle: Text("${p.difficulty}, ${p.estimatedHour}"),
                    ),
                  );
                },
              ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('HOWTOS'),
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

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Araçlar'),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _showMyDialog();
                    },
                    child: Text('Fidan Öğretmen\'imize sor'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      context.go('/search/ai');
                    },
                    child: Text('Yapay Zekaya Sor'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      context.go('/search/assignments');
                    },
                    child: Text('Ödevlerim'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      context.go('/search/sss');
                    },
                    child: Text('Sözlük'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

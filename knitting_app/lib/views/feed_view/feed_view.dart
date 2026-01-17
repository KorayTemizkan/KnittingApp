import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;
    //final auth = context.watch<AuthProviderFirebase>();
    final streak = context.watch<SharedPreferencesProvider>().streak;

    return Scaffold(
      appBar: AppBarWidget(title: 'Akış'),

      body: Center(
        child: Column(
          children: [
            // ŞİMDİLİK UYGULAMADA SADECE FİDAN VE ÖRGÜLERİ OLUCAK. TOPLULUĞA AÇIK HALE DAHA SONRA GETİRİCEM
            // Yana kaydırmalık ya da aşağı kaydırmalık dediklerim var ya, oralara ok ekleyelim
            // 6 UNSUR OLUCAK

            // MERHABA KORAY, 10 GÜNDÜR BİZİMLESİN,  SP içine ekle ve

            // FİDAN ÖĞRETMEN'DEN ÖDEVLER SERİSİ, YAPILAN ÖDEV SAYISI 7/22 ( Yana kaydırmalık ) başlangıça seçilen diffuculty'ye göre sırasıyla product önerelim sırasıyla, ürünü bitir, fotoğrafını bize yolla. onaylarsak olsun.düzeye göre bu herkese atansın, örneğin df 1 düzeyinde 15 tane, df 2 düzeyinde 7 tane, herkese toplam 22

            // YENİ EKLENENLER ( Yana kaydırmalık)

            // KNİTTİNG CAFELERİ KEŞFET ( Yana kaydırmalık )

            // EN ÇOK BEĞENİLEN/FAVORİLENEN PRODUCTS KISMI OLSUN, AKIŞ GİBİ( Aşağı kaydırmalık 4'lü grid), BURAYI EKLE, ANALYTİCS,

            Text('Merhaba x gündür bizimlesin'),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            GenericSearchAnchorBar<Searchable>(
              items: [...products],
              hintText: 'Ara...',
              onItemSelected: (item) {
                if (item is ProductModel) {
                  context.go('/products', extra: item);
                }
              },
            ),
            
            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Yeni eklenenler'),
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

            Text('Örgü Kafeleri'),
            Expanded(
              child: ListView.builder(
                itemCount: knittingCafes.length,
                itemBuilder: (context, index) {
                  final k = knittingCafes[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/knittingCafe', extra: k);
                      },

                      title: Text(k.name),
                      subtitle: Text("${k.address}, ${k.features}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

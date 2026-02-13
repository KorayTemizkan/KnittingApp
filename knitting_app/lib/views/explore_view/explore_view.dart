import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:knitting_app/controllers/widgets/content_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/info_card.dart';
import 'package:knitting_app/controllers/widgets/mini_info_card.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/controllers/widgets/title_text_with_category.dart';
import 'package:knitting_app/controllers/widgets/title_with_see_all.dart';
import 'package:knitting_app/controllers/widgets/vertical_card_list.dart';
import 'package:knitting_app/controllers/widgets/weekly_stars_card.dart';
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
  int selectedIndex = 0;

  Future<void> _showMyDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Merhaba teyzecim'),
          content: Text('''
Senin yazılımcı oğlun ya da kızın varsa Allah rızası için onlara şunu iletir misin?
Kızım ben telefona bir şey indirdim örgü filan öğreniyorum çok beğendim. Bunu yapan oğlan da staj arıyormuş
Allah rızası için filan diyor. Yardımcı olur musun kurban oldluğum.
'''),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Sordun di mi?'),
            ),
            TextButton(
              //onPressed: () => openWhatsAppSupport(),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Allah rızası için sor'),
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
      appBar: AppBarWidget(title: 'Eğitim'),
      body: ListView(
        // Scrollable yapmaktansa bunu yap, sadece ekranda ne varsa onu render eder
        children: [
          TitleText(text: 'Araçlar'),

          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 3, // 👈 BU ÇOK KRİTİK
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              MiniInfoCard(
                icon: Icons.menu_book,
                title: 'Rehber',
                onTap: 'sss',
              ),
              MiniInfoCard(
                icon: Icons.emoji_events,
                title: 'Yarışmalar',
                onTap: 'contests',
              ),
              MiniInfoCard(
                icon: Icons.smart_toy,
                title: 'Akıllı Tığcık',
                onTap: 'ai',
              ),
              //   MiniInfoCard(icon: Icons.question_answer, title: 'Soru Sor', onTap: ,),
            ],
          ),

          TitleText(text: 'Kategoriler'),

          // Amigurumi, Hediyelik, Üst Giyim, Alt Giyim, Aksesuar, Süs
          HorizontalCardList(
            itemCount: 20,
            height: 120,
            cardWidthRatio: 0.18,
            itemBuilder: (context, index) {
              return WeeklyStarsCard(
                title: "Takı",
                difficulty: "27 tarif",
                estimatedHour: "",
                onTap: () {},
              );
            },
          ),

          TitleTextWithCategory(title: 'Toplu Eğitimler'),

          TripleSegmentButton(
            titles: ['Eğitimler', 'Tarifler', 'Desenler'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          HorizontalCardList(
            itemCount: products.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {},
              );
            },
          ),

          TitleTextWithCategory(title: 'Tüm İçerikler'),

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

          VerticalCardList(
            itemCount: products.length,
            cardHeight: 260, // yükseklik
            crossAxisCount: 2, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {},
              );
            },
          ),

          /*
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
            */
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/comment_section.dart';
import 'package:knitting_app/controllers/widgets/content_card.dart';
import 'package:knitting_app/controllers/widgets/detail_card.dart';
import 'package:knitting_app/controllers/widgets/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/info_card.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/controllers/widgets/title_with_icon.dart';
import 'package:knitting_app/controllers/widgets/title_with_see_all.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final ProductModel product;
  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  bool isSaved = false; // burada neden string kullandın ki gerek yoktu akıllı
  bool isLiked = false;

  List<String> savedCharactersList = [];

  /*
  
  burada tüm uygulamada kullanmak için tek bir provider treferansı önerilmiyor.
  Context her zaman güvenli değildir ve lifecylcle bağlıdır. çünkü daha context oluşmadı,
  widget ağaca eklenmedi, provider tree hazır değil.
  Hot reload/ yeniden başlatma ya da başka durumlarda sorun çıkabilir
  o yüzden aşağıda elevated button içinde yeniden tanımlıyoruz.
  özet : en güvenli yol ihtiyaç anında context üzerinden almak veya build içinde okumaktır

  unutma ! Provider.of nesne oluşturmaz. O(1)'lik referans oluşturur.

  */
  @override
  void initState() {
    super.initState();

    final sp = context.read<SharedPreferencesProvider>();

    final savedRecipeslist = sp.savedRecipes;
    isSaved = savedRecipeslist.contains(widget.product.id.toString());

    final likedRecipesList = sp.likedRecipes;
    isLiked = likedRecipesList.contains(widget.product.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      appBar: AppBarWidget(title: 'Ayrıntı'),

      body: ListView(
        children: [
          DetailCard(), // Birinci parça: Görsel ve sağdaki küçük kart
          // Başlık ve İkonlar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Yazlık Battaniye",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_outline),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined),
                      color: Color(0xFFFF5722),
                      iconSize: 24,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Seviye ve Süre
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.show_chart, size: 24),
                SizedBox(width: 4),
                Text("Yeni Başlayan"),
                SizedBox(width: 20),
                Icon(Icons.access_time, size: 24),
                SizedBox(width: 4),
                Text("7 - 10 saat"),
              ],
            ),
          ),

          SizedBox(height: 20),

          TitleWithIcon(title: 'İhtiyaçlar', icon: Icons.inventory_2_outlined),

          // Gri Bilgi Kutusu
          Card(
            elevation: 1,
            margin: const EdgeInsets.all(8),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("İplik: Pamuk"),
                  SizedBox(height: 8),
                  Text("Renkler: Kırmızı, Yeşil"),
                  SizedBox(height: 8),
                  Text("Tığ numarası: 3.0 mm"),
                ],
              ),
            ),
          ),

          TitleWithIcon(title: 'Açıklama', icon: Icons.description_outlined),
          // Gri Bilgi Kutusu
          Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WAFEGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJIDSKOMIDKOPLMGIODFKMGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJGWKRHTMDIOXFGKJDRTIXGFNJGCKMDRFNVMKDLMDKMF GNMDFKSLFJ",
                  ),
                ],
              ),
            ),
          ),

          TitleWithIcon(
            title: 'Bilmen Gereken Teknikler',
            icon: Icons.auto_awesome_motion,
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
                onTap: () {
                  context.go('/product', extra: product);
                },
              );
            },
          ),

          TitleWithIcon(
            title: 'Eğitime Başla',
            icon: Icons.rocket_launch_outlined,
          ),

          Card(
            color: Color(0xFFFF5722),
            // margin: En dışta yatay ve dikey ne kadar boşluk olacağını ayarlar
            margin: EdgeInsets.only(top: 0, left: 16, right: 16),
            // elevation: Kartın altındaki gölge miktarını ayarlar.
            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
              side: const BorderSide(color: Color(0xFFFF5722), width: 1),
            ),

            child: Column(
              // Elemanlar nereye yatık dizilecek
              children: [
                // Elemanlar arası boşluğu ayarlar
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Sol taraftaki profil fotoğrafı ayarları
                      const CircleAvatar(
                        // Çap büyüklüğü
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline,
                          color: Color(0xFFFF5722),
                        ),
                      ),

                      // Elemanlar arası boşluğu ayarlar
                      const SizedBox(width: 16),

                      Text(
                        "Merhaba Koray :)",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      // Orta kısımdaki altı çizili metin
                      const Expanded(
                        child: Text(
                          "Eğitime Başlamaya Hazır Mısın?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Sağ alt köşedeki ok ikonu
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Color(0xFFFF5722),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          TitleWithSeeAll(text: 'Yorumlar'),

          PostCard(showComments: false),

          TitleText(text: 'İletişim'),

          CardList(
            widgets: [
              InfoCard(
                icon: Icon(Icons.abc_outlined),
                text: 'Aklına takılanı sor :)',
              ),
            ],
          ),
        ],
      ),
    );
  }

  ElevatedButton likeProduct(BuildContext context) => ElevatedButton(
    onPressed: () {
      setState(() {
        isLiked = !isLiked;
      });
    },
    child: Text(isLiked ? 'Unlike' : 'Like'),
  );

  ElevatedButton saveProduct(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final sp = context.read<SharedPreferencesProvider>();

        if (isSaved) {
          sp.removeSavedRecipe(widget.product.id);
        } else {
          sp.saveRecipe(widget.product.id);
        }

        setState(() {
          isSaved = !isSaved;
        });
      },
      child: Text(isSaved ? 'Unsave' : 'Save'),
    );
  }
}

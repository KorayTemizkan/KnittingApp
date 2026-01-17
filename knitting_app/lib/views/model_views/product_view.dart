import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
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

    final list = sp.savedCharacters;

    isSaved = list.contains(widget.product.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Ürün ayrintisi'),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Image.network(widget.product.imageUrl),
                title: Text(widget.product.title),
              ),
            ),

            saveProduct(context),
 
            likeProduct(context),

            // BURAYA GÖRÜNTÜLENME FONKSİYONU EKLEYECEĞİZ. KULLANICI HER BU SAYFAYI AÇTIĞINDA FİREBASE'E +1 SİNYAL YOLLAYACAĞIZ
          ],
        ),
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
          sp.removeCharacter(widget.product.id);
        } else {
          sp.saveCharacter(widget.product.id);
        }

        setState(() {
          isSaved = !isSaved;
        });
      },
      child: Text(isSaved ? 'Unsave' : 'Save'),
    );
  }

}

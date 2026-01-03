import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/models/how_to_model.dart';
import 'package:provider/provider.dart';

class HowToView extends StatefulWidget {
  final HowToModel howTo;
  const HowToView({super.key, required this.howTo});

  @override
  State<HowToView> createState() => _HowToViewState();
}

class _HowToViewState extends State<HowToView> {
  /*
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
    // TODO: implement initState
    super.initState();

    final sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(
      context,
      listen: false,
    ); // listen: false ile bu provideri sadece oku diyor
    /* eğer böyle olsaydı:
final sp = Provider.of<SharedPreferencesProvider>(context);

widget bu providera abone olur. provider içinde notify listeners çağrılırsa widget rebuild olur
ne zaman kullanalım :

örneğin ekranda veri göstereceğiz (mesela streak),
    */
    sharedPreferencesProvider.finishGetSavedCharacters().then((list) {
      setState(() {
        savedCharactersList = list;
        isSaved = savedCharactersList.contains(widget.product.id.toString());
      });
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Ürün ayrintisi'),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Image.network(widget.howTo.imageUrl),
                title: Text(widget.howTo.title),
              ),
            ),

            //saveProduct(context),

            //likeProduct(context),
          ],
        ),
      ),
    );
  }
/*
  ElevatedButton likeProduct(BuildContext context) => ElevatedButton(
    onPressed: () {},
    child: Text(isLiked ? 'Unlike' : 'Like'),
  );

  ElevatedButton saveProduct(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final sharedPreferencesProvider =
            Provider.of<SharedPreferencesProvider>(context, listen: false);

        if (isSaved) {
          await sharedPreferencesProvider.finishRemoveCharacter(
            widget.product.id,
          );
        } else {
          await sharedPreferencesProvider.finishSaveCharacter(
            widget.product.id,
          );
        }

        setState(() {
          isSaved = !isSaved;
        });
      },

      child: Text(isSaved ? 'Unsave' : 'Save'),
    );
  }
  */
}

/*
Çalışma Akışı:

Model -> Provider -> View -> HorizontalCardList -> ContentCardList
*/

import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  final int itemCount; // kart adeti
  final double
  height; // kart yükseliği (eğer vermezsek vertical viewport was given unbounded height hatası alırız)
  final double cardWidthRatio; // yatayda kaç kart gözükecek
  final Widget Function(BuildContext, int)
  itemBuilder; // Sen bana index ver ben onu çizeyim

  const HorizontalCardList({
    super.key,
    required this.itemCount,
    required this.height,
    required this.cardWidthRatio,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(
      context,
    ).size.width; // Telefonun anlık genişliği

    // yatay liste mutlaka bir yükseklik ister. Biz bunu ayarlıyoruz. SizedBox nedeni bu
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // sağa doğru kaydırma özelliği
        padding: const EdgeInsets.only(left: 8),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SizedBox(
            // Artık bir kart seviyesine indik. Burada yataty uzunluk ayarlanıyor
            width: screenWidth * cardWidthRatio,
            child: itemBuilder(
              context,
              index,
            ), // burada dışarıdan gelen itemBuilder çizilir
          );
        },
      ),
    );
  }
}

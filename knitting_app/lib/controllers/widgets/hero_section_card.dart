import 'package:flutter/material.dart';

class HeroSectionCard extends StatelessWidget {
  const HeroSectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFF5722),
      // margin: En dışta yatay ve dikey ne kadar boşluk olacağını ayarlar
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
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
                  child: Icon(Icons.person_outline, color: Color(0xFFFF5722)),
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
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                // Orta kısımdaki altı çizili metin
                const Expanded(
                  child: Text(
                    "Kaldığın Yerden Devam Et",
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
                  child: Icon(Icons.arrow_forward, color: Color(0xFFFF5722)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final bool showComments;

  const PostCard({super.key, required this.showComments});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Üst Kısım: Profil Bilgileri
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFFF5722),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ), // Kişinin fotoğrafı gelecek
                ),

                SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Koray Temizkan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "@kkkkorayyyy * 15 dk",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined),
                  color: Color(0xFFFF5722),
                  iconSize: 24,
                ),
              ],
            ),

            // 2. Paylaşım Metni
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Bugün örgü yapmayı çok sevdim, bu modelin detayları harika oldu!",
                style: TextStyle(fontSize: 15),
              ),
            ),

            // 3. Büyük Fotoğraf Alanı (Genişletilmiş)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                height: 250, // Fotoğraf artık daha büyük ve belirgin
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                    // Sağ alt köşedeki sade tıklama ikonu
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Icon(
                        Icons.touch_app,
                        color: Colors.black45,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Divider(height: 2, color: Color(0xFFFF5722)),

            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                  color: Color(0xFFFF5722),
                  iconSize: 24,
                ),
                Text('127'),
                SizedBox(width: 8),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.comment_outlined),
                  color: Color(0xFFFF5722),
                  iconSize: 24,
                ),
                Text('127'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

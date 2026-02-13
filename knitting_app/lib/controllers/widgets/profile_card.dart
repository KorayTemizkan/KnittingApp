import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      padding: EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        children: [
          // Banner ve Profil Resmi
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFFF5722),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
              ),
              Positioned(
                bottom: -40,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 230, 216, 216),
                  child: Icon(
                    Icons.person_outline,
                    size: 60,
                    color: Color(0xFFFF5722),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 50),

          // İsim ve Kullanıcı Adı
          Text(
            "Koray Temizkan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text("@kkkkorayyy", style: TextStyle(color: Colors.grey)),

          // İstatistikler (Beğeni, Takip, Göz)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatItem(Icons.favorite_border, "18"),
                SizedBox(width: 20),
                _buildStatItem(Icons.person_outline, "27"),
                SizedBox(width: 20),
                _buildStatItem(Icons.visibility_outlined, "157"),
              ],
            ),
          ),

          // Biyografi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Örgü modelleri ve amigurumi tasarımları yapıyorum. Yeni tarifler için takipte kalın!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),

          // Düzenle ve Sosyal Medya
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.go('/profile/editProfile');
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Düzenle'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF5722),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
            
                SizedBox(width: 16),
            
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.go('/profile/share');
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Paylaş'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF5722),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black87),
        SizedBox(width: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/widgets/profile_card.dart';
import 'package:knitting_app/controllers/widgets/success_card.dart';

class ShareView extends StatefulWidget {
  const ShareView({super.key});

  @override
  State<ShareView> createState() => _ShareViewState();
}

class _ShareViewState extends State<ShareView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Paylaş'),
      body: Column(
        children: [
          Container(
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
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -40,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: const Color.fromARGB(
                          255,
                          230,
                          216,
                          216,
                        ),
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
                SizedBox(height: 5),
                Text(
                  "@kkkkorayyyy",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text("+90 534 393 6207", style: TextStyle(color: Colors.grey)),

                SuccessCard(),

                // Biyografi
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Sağ alt köşedeki ok ikonu
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFF5722),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.ios_share, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(textAlign: TextAlign.center, 'Profili\nPaylaş'),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFF5722),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.link, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(textAlign: TextAlign.center, 'Linki\nKopyala'),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFF5722),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.image, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(textAlign: TextAlign.center, 'Karekodu\nPaylaş'),
                        ],
                      ),

                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFF5722),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.download_rounded, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(textAlign: TextAlign.center, 'Kartı\nKaydet'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _imagePath = '';
  String imageUrl = '';
  Future<void> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<SupabaseProvider>().readPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Topluluk'),
      body: Center(
        child: Column(
          children: [
            /*
            Bu kısımla ilgili düşüncelerim tam net değil ama şimdilik orta boyutta bir logomuzu buraya koyup yakında! uyarısı versek yeter sanırım.
            
            4 UNSUR OLUCAK
            
            Facebook gönderi atabilme: Gönderi atabilme, takip ettiğin insanların gönderileri ya da 
            Facebook profilleri ve arama:Farklı kullanıcıları görebilme, profil sayfalarına gidebilme olsun. - Kullanıcı arama olsun, ama normal olarak ayın enleri yapalım. aktiflik sıralamasına göre ayın 50'si filan olsun
            Facebook grupları: Örgü kafe toplulukları olsun. O kafelerin sahipleri doğrulama yaparsa onlar eklenebilir mesela. Ya da birisi Bursa Nilüferciler diye bir topluluk kursun ve üyeleri olsun. Bu toplulukların sayfası olsun. Bu topluluklarda gönderi atılınca sadece buraya özel olsun. Bu topluluğa giriş onayla olsun.
            
            Mesajlaşma yerine gönderilere yorum atma olsun şimdilik
            */
            SizedBox(height: 10),

            Text('GÖNDERİ ATMA'),

            TextField(
              controller: _headerController,
              decoration: InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'İçerik',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                pickImage();
              },
              child: Text('Görsel seç'),
            ),

            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),

            ElevatedButton(
              onPressed: () async {
                await context.read<SupabaseProvider>().uploadPhoto(
                  selectedImage: _selectedImage!,
                );
                await context.read<SupabaseProvider>().insert(
                  header: _headerController.text,
                  content: _contentController.text,
                );
              },
              child: Text('Paylaş'),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('TÜM KULLANICILAR'),
            // Şimdilik tüm kullanıcıları listeleme fonksiyonu ekleyelim
            Divider(height: 50, thickness: 15, color: Colors.amber),

            
            Text('GÖNDERİLERİM'),
          
            Expanded(
              child: Consumer<SupabaseProvider>(
                // provider içindeki veriyi dinleyip sadece o widgeti yeniden çizmek için kullanılan bir widgettir.
                builder: (context, provider, _) {
                  final posts = provider.posts;

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final p = posts[index];

                      return Card(
                        child: ListTile(
                          title: Text(p['header'] ?? ''),
                          subtitle: Text(p['content'] ?? ''),
                        ),
                      );
                    },
                  );
                },
              ),
            ),




            // Tüm gönderiler
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),

            // Takipçi sayısına göre kişiler
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),
            //Kişi ara: GenericSearchAnchorBar(items: items, onItemSelected: onItemSelected)

            // Takipçi sayısına göre topluluklar
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),
            //Topluluk ara: GenericSearchAnchorBar(items: items, onItemSelected: onItemSelected)
          ],
        ),
      ),
    );
  }
}

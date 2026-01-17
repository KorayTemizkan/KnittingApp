import 'dart:io';
import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/notes_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/models/note_model.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<int> savedIds = [];
  List<Note> notes = [];
  String? photoPath;
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedIds();
  }

  // BU İKİ FONKSİYON İNTERNET OLMADIĞINDA BAĞLANMAK İÇİN

  void _loadSavedIds() {
    final sp = context.read<SharedPreferencesProvider>();

    final stringList = sp.savedCharacters;

    setState(() {
      savedIds = stringList
          .map((e) => int.tryParse(e))
          .whereType<int>()
          .toList();

      photoPath = sp.profilePhoto;
    });
  }


  /// 🔹 savedIds sırasına göre product.id eşleştirir
  /// artık productMap[3] -> Bere gibi oldu
  List<ProductModel> _getSavedProducts({
    required List<int> savedIds,
    required List<ProductModel> products,
  }) {
    final productMap = {
      for (final p in products) p.id: p,
    }; // products listesini mape çevir

    return savedIds
        .map((id) => productMap[id])
        .whereType<ProductModel>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final notesProvider = context.watch<NotesProvider>();
    notes = notesProvider.notes;

    if (products.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final savedProducts = _getSavedProducts(
      savedIds: savedIds,
      products: products,
    );

    return Scaffold(
      appBar: AppBarWidget(title: 'Profil'),
      body: Center(
        child: Column(
          children: [
            /*

            // 4 UNSUR OLUCAK

            // PROFİL
            // KAYDEDİLENLER ( Yana kaydırmalık + yine tam ekrana alma seçeneği olabilir)
            // BEĞENİLENLER ( Yana kaydırmalık +)
            // NOTLARIM ( Yana kaydırmalık +)
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: <Widget>[
                  Text('KULLANICI BILGILERI'),
                  //Text(authProvider.email ?? 'Giris yapilmadi'),
                  //Text(authProvider.uid ?? 'ID yok'),

                  photoPath != null
                      ? Image.file(
                          File(photoPath!),
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : const CircleAvatar(
                          radius: 60,
                          child: Icon(Icons.person),
                        ),

                  ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<SharedPreferencesProvider>()
                          .pickProfileImage();

                      setState(() {
                        photoPath = context
                            .read<SharedPreferencesProvider>()
                            .profilePhoto;
                      });
                    },
                    child: const Text("Profil fotografi koy!"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      await context
                          .read<SharedPreferencesProvider>()
                          .finishSetFirstOpeningTrue();

                      setState(() {});
                    },
                    child: const Text("İlk girisi ac!"),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      authProvider.signOut();
                    },
                    child: Text('Cikis yap!'),
                  ),
                ],
              ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Kaydedilenler'),
            SavedProducts(savedProducts),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('Beğenilenler'),
            SavedProducts(savedProducts),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            TextField(
              controller: _noteTitleController,
              decoration: InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),

            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Not',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
            ),

            ElevatedButton(
              onPressed: () async {
                await notesProvider.addNote(
                  _noteTitleController.text,
                  _noteController.text,
                );
              },

              child: const Text('Not ekle'),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final n = notes[index];

                  return Card(
                    child: ExpansionTile(
                      title: Text(n.title),
                      subtitle: Text('${n.time}'),
                      children: [
                        Text(n.note)
                      ],
                    ),
                  );
                },
              ),
            ),

            */
          ],
        ),
      ),
    );
  }

  Expanded SavedProducts(List<ProductModel> savedProducts) {
    return Expanded(
      child: ListView.builder(
        itemCount: savedProducts.length,
        itemBuilder: (context, index) {
          final p = savedProducts[index];

          return Card(
            child: ListTile(
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
    );
  }
}

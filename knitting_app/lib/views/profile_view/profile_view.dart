import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
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
  String? photoPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedIds();
  }

  // BU İKİ FONKSİYON İNTERNET OLMADIĞINDA BAĞLANMAK İÇİN

  Future<void> _loadSavedIds() async {
    final sharedPreferencesProvider = context.read<SharedPreferencesProvider>();
    final stringList = await sharedPreferencesProvider
        .finishGetSavedCharacters();

    setState(() {
      savedIds = stringList
          .map((e) => int.tryParse(e))
          .whereType<int>()
          .toList();
      photoPath = sharedPreferencesProvider.profilePhoto;
    }); // setstate kullanıyoruz çünkü bu dosyadaki savedID's değeri değişecek
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
    final auth = context.watch<AuthProviderFirebase>();

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
            Text('KULLANICI BILGILERI'),
            Text(auth.email ?? 'Giris yapilmadi'),
            Text(auth.uid ?? 'ID yok'),

            photoPath != null
                ? Image.file(
                    File(photoPath!),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )
                : const CircleAvatar(radius: 60, child: Icon(Icons.person)),

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
                auth.signOut();
              },
              child: Text('Cikis yap!'),
            ),

            SavedProducts(savedProducts),
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

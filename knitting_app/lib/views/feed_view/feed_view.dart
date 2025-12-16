import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:provider/provider.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  // initState() sayfa ilk kez açıldığında bir kere çalışır
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).loadProducts(); // provider ile ProductProvider nesnesine erişip loadProducts fonksiyonunu çağırıyoruz
  }

  @override
  Widget build(BuildContext context) {
    // buradaki build loadProducts içindeki notiftyListeners yüzünden yeniden tetiklendi
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    if (productProvider.isLoading) {
      // loadProducts işlemi devam ederken kullanıcıları kandırmak için döndürme getiriyoruz
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('feed_view'),
            Text('kullanıcıya özel selamlama'),
            Text('giriş serisi'),
            Text('gunun challengi'),
            Text('hedef takibi'),
            Text('haftalik yarışma'),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];

                  return Card(
                    child: ListTile(
                      onTap: () {
                        context.go('/product', extra: p);
                      },

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
            ),

            SearchAnchor.bar(
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                    final String input = controller.text.toLowerCase();

                    return products
                        .where(
                          (item) => item.title.toLowerCase().contains(input),
                        )
                        .map(
                          (filteredItem) => ListTile(
                            title: Text(filteredItem.title),
                            onTap: () {
                              controller.closeView(filteredItem.title);
                              context.go('/product', extra: filteredItem);
                            },
                          ),
                        )
                        .toList();
                  },
            ),
          ],
        ),
      ),
    );
  }
}

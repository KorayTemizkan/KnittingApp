import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier { // changenotifier sayesinde notify listeners çağırabiliyoruz
  List<ProductModel> _products = []; // private yaptık ki dışarıdan erişilmesin
  bool _isLoading = false;

// dış dünyaya kontrollü bir şekilde sadece okuma izni veriyoruz, güzel bir alışkanlık
  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners(); // provideri dinleyen tüm widgetler, kendinizi yeniden yükleyin demek

    _products = await fetchProducts();

    _isLoading = false;
    notifyListeners();
  }
}

/*

provider : durum yönetimi için kullanılan bir yapıdır
veriyi tek bir yerde tutar, birden fazla widgetin aynı veriye erişmesini sağlar ve veri değişince widgetleri otomatik yeniden çizdirir

böylece kod şişmez, veri başka yerde lazım olursa kullanabilirsin, sayfalar arası veri paylaşımı kolaylaşır, test etmesi kolaylaşır

*/
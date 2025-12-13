import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/models/product_model.dart';

class ProductView extends StatelessWidget {
  final ProductModel product;
  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarWidget(title: 'Knitting App - Ürün ayrintisi'),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Image.network(product.imageUrl),
                title: Text(product.title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

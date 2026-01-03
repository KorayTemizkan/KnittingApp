import 'package:http/http.dart' as http;
import 'package:knitting_app/models/how_to_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:knitting_app/models/product_model.dart';

Future<List<ProductModel>> fetchProducts() async {
  final response = await http.get(
    Uri.parse(
      'https://raw.githubusercontent.com/KorayTemizkan/KnittingApp/main/products.json',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList.map((item) => ProductModel.fromMap(item)).toList();
  } else {
    throw Exception(
      'Failed to load products. Code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
    );
  }
}

Future<List<HowToModel>> fetchHowTos() async {
  final response = await http.get(
    Uri.parse(
      'https://raw.githubusercontent.com/KorayTemizkan/KnittingApp/main/howTos.json',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList.map((item) => HowToModel.fromMap(item)).toList();
  } else {
    throw Exception(
      'Failed to load howtos. Code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
    );
  }
}

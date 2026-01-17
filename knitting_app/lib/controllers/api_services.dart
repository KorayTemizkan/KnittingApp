import 'package:http/http.dart' as http;
import 'package:knitting_app/models/how_to_model.dart';
import 'package:knitting_app/models/knitting_cafe_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:knitting_app/models/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:io';

import 'package:knitting_app/models/release_note_model.dart';

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
      'Failed to load howTos. Code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
    );
  }
}

Future<List<KnittingCafeModel>> fetchKnittingCafes() async {
  final response = await http.get(
    Uri.parse(
      'https://raw.githubusercontent.com/KorayTemizkan/KnittingApp/main/knittingCafes.json',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList.map((item) => KnittingCafeModel.fromMap(item)).toList();
  } else {
    throw Exception(
      'Failed to load knittingCafes. Code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
    );
  }
}

Future<List<ReleaseNoteModel>> fetchReleaseNotes() async {
  final response = await http.get(
    Uri.parse(
      'https://raw.githubusercontent.com/KorayTemizkan/KnittingApp/main/releaseNotes.json',
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);

    return jsonList.map((item) => ReleaseNoteModel.fromMap(item)).toList();
  } else {
    throw Exception(
      'Failed to load releaseNotes. Code: ${response.statusCode}, Reason: ${response.reasonPhrase}',
    );
  }
}

Future<String> askGPT({required String question, File? imageFile}) async {
  final apiKey = dotenv.env['OPENAI_API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('OPENAI_API_KEY bulunamadı');
  }

  String prompt =
      '''
  Eğer bir fotoğraf yüklendiyse:
  - Fotoğraftaki örgü modelini, metin ile beraber analiz et. Kullanıcının isteğine göre yorum yap
  - Model türünü (ör. düz, haroşa, ajur, saç örgü vb.) belirt.
  - Zorluk seviyesini (kolay / orta / zor) yaz.
  - Tahmini şiş numarasını ve ip türünü açıkla.
  - Benzer örgü modelleri öner.
  - Fotoğraf üretme veya montaj yapma.
  - Sadece analiz yap.

  Eğer fotoğraf yüklenmediyse:
  - Sadece verilen metni analiz et ve kullanıcının isteğine göre yorum yap.
  - Metne göre örgü modeliyle ilgili yorum yap.
  - Varsayım yaptığını açıkça belirt.

  Cevabı açık, sade ve maddeler halinde yaz.

  Kullanıcı metni:
  $question
  ''';

  final List<Map<String, dynamic>> content = [
    {"type": "text", "text": prompt},
  ];

  if (imageFile != null) {
    final bytes = await imageFile!.readAsBytes();
    final base64Image = base64Encode(bytes);

    content.add({
      "type": "image_url",
      "image_url": {"url": "data:/image/jpeg;base64,$base64Image"},
    });
  }
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      "model": "gpt-4o-mini",
      "messages": [
        {"role": "user", "content": content},
      ],
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data['choices'][0]['message']['content'] as String;
  } else {
    throw Exception(
      'Failed to load AI Answer. '
      'Code: ${response.statusCode}, '
      'Reason: ${response.body}',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:knitting_app/controllers/providers/ai_answers_provider.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/take_note.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/models/ai_answer_model.dart';
import 'package:provider/provider.dart';

class AiView extends StatefulWidget {
  const AiView({super.key});

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  List<AiAnswerModel> aiAnswers = [];

  final TextEditingController _questionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String _imagePath = "";

  String result = "";
  bool isResultLoading = false;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  // Diyalog açıkken async yapmak UX için kötüdür. Onay önce, işlem sonra yapılsın
  Future<void> _showMyDialog() async {
    final approved = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // kullanıcı
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uyarı!'),
          content: Text(
            'Her bir sorgunuz günlük yapay zeka kotanızdan bir azaltır. Şuanki hakkınız x/20 -> Sonraki hakkınız x-1/20. Göndermrek istediğinze emin imisniz',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('İptal'),
            ),

            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Onayla'),
            ),
          ],
        );
      },
    );

    if (approved == true) {
      _sendQuestion();
    }
  }

  Future<void> _sendQuestion() async {
    // ilk setstate yapılır bunu unutma
    setState(() {
      isResultLoading = true;
    });

    try {
      final _aiAnswer = await askGPT(
        question: _questionController.text,
        imageFile: _selectedImage,
      );

      context.read<AiAnswersProvider>().addAiAnswer(
        _questionController.text,
        _aiAnswer,
        _imagePath,
      );

      setState(() {
        result = _aiAnswer;
      });
    } catch (e) {
      setState(() {
        result = "Bir hata olustu: $e";
      });
    } finally {
      setState(() {
        isResultLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final aiAnswersProvider = context.watch<AiAnswersProvider>();
    aiAnswers = aiAnswersProvider.aiAnswers;

    return Scaffold(
      appBar: AppBarWidget(title: 'Akıllı Tığcık-a Sor'),

      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            elevation: 1,

            child: Padding(
              padding: const EdgeInsetsGeometry.all(24.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xFFFF5722),
                        child: Icon(
                          Icons.smart_toy_outlined,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          'Merhaba!\nBen Akıllı Tığcık!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Akıllı Tığcık-a Sor'
                    ' Sayfasına Hoş Geldiniz! Burada metin ve görsel yükleme yardımıyla yapay zekaya soru sorabilir ve yanıt alabilirsiniz',
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => context.go('/register'),
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 20,
                    color: Color(0xFFFF5722),
                  ),
                  label: const Text(
                    'Sıfırla',
                    style: TextStyle(color: Color(0xFFFF5722)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Kalan Soru Hakkı: 7/24'),
                ),

              ],
            ),
          ),


         TakeNote(minLines: 4, controller: _questionController, labelText: 'Ne düşünüyorsun?'),

           // --- Alt Aksiyonlar (Görsel ve Paylaş) ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text('Görsel Ekle (0/2)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFF5722),
                      side: const BorderSide(color: Color(0xFFFF5722)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5722),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Akıllı Tığcık\'a Sor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          TitleText(text: 'Önceki Sorularım'),

          /*
                GenericSearchAnchorBar<Searchable>(
            items: [...products, ...howTos],
            hintText: 'Ara...',
            onItemSelected: (item) {
              if (item is ProductModel) {
                context.go('/products', extra: item);
              } else if (item is HowToModel) {
                context.go('/howTo', extra: item);
              }
            },
          ),
          */
          CardList(
            widgets: [
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaoruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Uygulama Kullanımı',
                subtitle: 'Aklına takılan soruları yanıtlayalım',
              ),
            ],
          ),

          /*
          Text('Günlük kullanım kotanız: x/20'),
          Text(
            'Merhaba, bu bölümde yapay zekaya metin bazlı soru sorabilir, Takıldığınız noktada yapmaya çalıştığınız örgünün fotoğrafını çekip yollayabilirsiniz vb vb.',
          ),

          TextField(
            controller: _questionController,
            decoration: InputDecoration(
              labelText: 'Sorunu yaz',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),

          if (_selectedImage != null)
            Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),

          ElevatedButton(
            onPressed: () {
              _pickImage();
            },
            child: Text('Görsel seç'),
          ),

          ElevatedButton(
            onPressed: () {
              _showMyDialog();
            },
            child: Text('Gönder'),
          ),

          if (isResultLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          if (!isResultLoading && result.isNotEmpty)
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: SelectableText(result),
            ),

          Divider(height: 50, thickness: 15, color: Colors.amber),

          Text('Önceki sorguların'),

          Expanded(
            child: ListView.builder(
              itemCount: aiAnswers.length,
              itemBuilder: (context, index) {
                final ai = aiAnswers[index];

                return Card(
                  child: ExpansionTile(
                    title: Text(ai.question),
                    subtitle: Text(ai.time.toString()),
                    children: <Widget>[Text(ai.answer)],
                  ),
                );
              },
            ),
          ),
          */
        ],
      ),
    );
  }
}

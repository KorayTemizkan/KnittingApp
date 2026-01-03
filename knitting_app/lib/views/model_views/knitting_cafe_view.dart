import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/models/knitting_cafe_model.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:provider/provider.dart';

class KnittingCafeView extends StatefulWidget {
  final KnittingCafeModel knittingCafe;
  const KnittingCafeView({super.key, required this.knittingCafe});

  @override
  State<KnittingCafeView> createState() => _KnittingCafeViewState();
}

class _KnittingCafeViewState extends State<KnittingCafeView> {
  bool isSaved = false;
  bool isLiked = false;

  List<String> savedCafeList = [];

  @override
  void initState() {
    super.initState();
 
    /*
    final sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(
      context,
      listen: false,
    );
    sharedPreferencesProvider.finishGetSavedCafes().then((list) {
      setState(() {
        savedCafeList = list;
        isSaved = savedCafeList.contains(widget.cafe.id.toString());
      });
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Kafe Detayı'),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// KAFE BİLGİSİ
            Card(
              margin: const EdgeInsets.all(12),
              child: ListTile(
                title: Text(
                  widget.knittingCafe.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.knittingCafe.address),
              ),
            ),

            /// BUTONLAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [saveCafe(context), likeCafe()],
            ),
          ],
        ),
      ),
    );
  }

  /// LIKE
  ElevatedButton likeCafe() => ElevatedButton(
    onPressed: () {
      setState(() {
        isLiked = !isLiked;
      });
    },
    child: Text(isLiked ? 'Unlike' : 'Like'),
  );

  /// SAVE
  ElevatedButton saveCafe(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        /*
        final sharedPreferencesProvider =
            Provider.of<SharedPreferencesProvider>(context, listen: false);
        if (isSaved) {
          await sharedPreferencesProvider.finishRemoveCafe(widget.cafe.id);
        } else {
          await sharedPreferencesProvider.finishSaveCafe(widget.cafe.id);
        }
        */

        setState(() {
          isSaved = !isSaved;
        });
      },
      child: Text(isSaved ? 'Unsave' : 'Save'),
    );
  }
}
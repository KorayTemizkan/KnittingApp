import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;

    return Scaffold(
      appBar: AppBarWidget(title: 'Keşfet'),

      body: ListView(
        children: [
          SizedBox(height: 16),

          GenericSearchAnchorBar(
            items: [...knittingCafes],
            onItemSelected: (item) {
              context.go('knittingCafes', extra: item);
            },
          ),

          SizedBox(height: 8),

          // Supabase'den postlar tablosundan görsel eklenmiş olanlardan beğeni sayısına göre çek
          // Eğitimler ise setler harici bireysel olarak çek
          TripleSegmentButton(
            titles: ['Herkes', 'Takip', 'Eğitim'],
            selectedIndex: selectedIndex,
            onChanged: (value) {},
          ),

          SizedBox(height: 16),

          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                color: Color(0xFFFF5722),

              );
            },
          ),
        ],
      ),
    );
  }
}

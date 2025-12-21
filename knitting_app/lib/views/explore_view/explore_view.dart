import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _SearchViewState();
}

class _SearchViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarWidget(title: 'KnittingApp - Keşfet'),
      body: Center(
        child: Column(
          children: [
            Text('explore_view'),
            Text('Temel örgü teknikleri'),
            Text('Fidan Öğretmenimizden rehberler'),
            Text('Odevler'),
            Text('Fidan öğretmenimize sor'),
            Text('Yapay zekaya sor'),           
          ],
        ),
      ),
    );  }
}
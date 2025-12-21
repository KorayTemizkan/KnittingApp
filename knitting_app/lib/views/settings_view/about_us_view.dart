import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'KnittingApp - AboutUs'),

      body: Column(
        children: [
          Text('Biz Kimiz?'),
        ],
      ),
    );
  }
}
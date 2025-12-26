import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Hakkımızda'),

      body: Column(
        children: [
          Text('Biz Kimiz?'),
        ],
      ),
    );
  }
}
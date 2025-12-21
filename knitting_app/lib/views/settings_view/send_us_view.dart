import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class SendUsView extends StatelessWidget {
  const SendUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'KnittingApp - SendUs'),

      body: Column(
        children: [
          Text('Bize sor!'),
        ],
      ),
    );
  }
}
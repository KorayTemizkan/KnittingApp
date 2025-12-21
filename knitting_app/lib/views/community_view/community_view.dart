import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarWidget(title: 'KnittingApp - Topluluk'),
      body: Center(
        child: Column(
          children: [
            Text('community_view'),
          ],
        ),
      ),
    );  }
}
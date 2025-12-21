import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBarWidget(title: 'KnittingApp - Profil'),
      body: Center(
        child: Column(
          children: [
            Text('profile_view'),
            Text('kullanıcı kartı'),
            Text('kaydedilenler'),
            Text('beğenilenler'),
          ],
        ),
      ),
    );  }
}
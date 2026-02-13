import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/router.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Color(0xFFFF5722),fontWeight: FontWeight.bold),),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 0.5, color: Color(0xFFFF5722)),
      ),

      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,

      actions: [
        IconButton(
          onPressed: () => context.push(AppRoutes.settings),
          icon: const Icon(color: Color(0xFFFF5722), Icons.notifications),
        ),
        IconButton(
          onPressed: () => context.push(AppRoutes.settings),
          icon: const Icon(color: Color(0xFFFF5722), Icons.settings),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56); // benim app barım 56 px yüksekliğinde, (56 standart yükseklik)
}

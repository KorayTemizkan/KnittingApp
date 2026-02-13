import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFFF5722), width: 0.5)),
        ),
        child: NavigationBarTheme(

          data: NavigationBarThemeData(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(color: Color(0xFFFF5722), size: 24);
              }
              return const IconThemeData(
                color: Color(0xFF1E1E1E),
                size: 24,
              ); 
            }),
          ),

          child: NavigationBar(
            height:
                60, // Yüksekliği buradan küçültebilirsin (Varsayılanı genelde 80'dir)
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
            labelBehavior: NavigationDestinationLabelBehavior
                .alwaysHide, // Yazıları tamamen gizler
            destinations: [
              _menuItem(context, icon: Icons.home, label: 'Ana Sayfa'),
              _menuItem(context, icon: Icons.search, label: 'Keşfet'),
              _menuItem(context, icon: Icons.import_contacts, label: 'Eğitim'),
              _menuItem(context, icon: Icons.groups, label: 'Topluluk'),
              _menuItem(context, icon: Icons.account_circle, label: 'Profil'),
            ],
          ),

        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(icon: Icon(icon), label: label);
  }
}

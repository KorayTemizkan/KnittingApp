import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
       
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
        ),

        child: NavigationBar(
          
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,

          destinations: [
            _menuItem(
              context,

              index: 0,
              currentIndex: navigationShell.currentIndex,
              label: 'Feed',
              icon: Icons.feed,
            ),

            _menuItem(
              context,

              index: 1,
              currentIndex: navigationShell.currentIndex,
              label: 'Explore',
              icon: Icons.explore,
            ),

            _menuItem(
              context,

              index: 2,
              currentIndex: navigationShell.currentIndex,
              label: 'Community',
              icon: Icons.escalator_sharp,
            ),

            _menuItem(
              context,

              index: 3,
              currentIndex: navigationShell.currentIndex,
              label: 'Profile',
              icon: Icons.home,
            ),
            
          ]
        ),
      ),
    );
  }


  Widget _menuItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required String label,
    required IconData icon,
  }) {
    return NavigationDestination(
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.black : Colors.red,
      ),
      label: label,
    );
  }


}

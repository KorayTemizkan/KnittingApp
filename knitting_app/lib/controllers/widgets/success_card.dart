import 'package:flutter/material.dart';

class SuccessCard extends StatelessWidget {
  const SuccessCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _achievementItem(Icons.calendar_today_outlined, "12", "gün"),
            _achievementItem(Icons.workspace_premium_outlined, "360", "tığcık"),
            _achievementItem(Icons.school_outlined, "7/18", "eğitim"),
            _achievementItem(Icons.menu_book_outlined, "3/36", "tarif"),
            _achievementItem(Icons.auto_stories_outlined, "8/18", "desen"),
          ],
        ),
      ),
    );
  }

  // Her bir başarı kalemi
  Widget _achievementItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Color(0xFFFF5722)),

          const SizedBox(height: 2),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

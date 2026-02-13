import 'package:flutter/material.dart';

class WeeklyStarsCard extends StatelessWidget {
  final String title; // @kullanıcıAdı
  final String difficulty; // 540 tığcık
  final String estimatedHour; // boş bırakılabilir
  final VoidCallback? onTap;

  const WeeklyStarsCard({
    super.key,
    required this.title,
    required this.difficulty,
    required this.estimatedHour,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFF5722), Color(0xFFFF8A50),],
                ),
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: const Icon(Icons.person, color: Color(0xFFFF5722)),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(
              difficulty,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        )

      ),
    );
  }
}

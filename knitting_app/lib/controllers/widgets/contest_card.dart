import 'package:flutter/material.dart';

class ContestCard extends StatelessWidget {
  String teacher;
  String name;
  String difficulty;
  String header;
  String content;

  ContestCard({
    super.key,
    required this.teacher,
    required this.name,
    required this.difficulty,
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ÜST KISIM
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFFF5722),
                  child: Text(
                    teacher[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(difficulty, style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined),
                  color: Color(0xFFFF5722),
                  iconSize: 24,
                ),
                
              ],
            ),

            const SizedBox(height: 16),

            // GÖRSEL ALANI
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.grey[300],
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.image, size: 60, color: Colors.grey[500]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // PUAN
            Text(
              header,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 4),

            Text(content, style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 16),

            // BUTONLAR
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                  color: Color(0xFFFF5722),
                  iconSize: 24,
                ),
                Text('127'),
                SizedBox(width: 8),


               IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                  color: Color(0xFFFF5722),
                  iconSize: 24,
                ),
                Text('127'),
                SizedBox(width: 8),

                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('Ayrıntılar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF5722),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BonusCard extends StatelessWidget {
  final String bonusType;
  final String bonus;
  const BonusCard({super.key, required this.bonusType, required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16, left: 8, right: 8),
      color: Color(0xFFFF5722),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x30FFFFFF),
                    ),
                    child: Icon(
                      color: Colors.white,
                      Icons.card_giftcard,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    bonusType,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Text(
                bonus,
                style: TextStyle(
                  color: Color(0xFFFF5722),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

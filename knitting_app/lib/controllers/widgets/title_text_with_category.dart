import 'package:flutter/material.dart';

class TitleTextWithCategory extends StatelessWidget {
  final String title;

  TitleTextWithCategory({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          /*
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFFFF5722),
            ),
            label: Text(
              'Başlangıç',
              style: TextStyle(fontSize: 16, color: Color(0xFFFF5722)),
            ),
            icon: Icon(Icons.arrow_drop_down, color: Color(0xFFFF5722)),
          ),*/
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconEnabledColor: Color(0xFFFF5722),
              // isExpanded: true,
              alignment: Alignment.center,
              dropdownColor: Colors.white,
              underline: Container(height: 0.5, color: const Color(0xFFFF5722)),
              hint: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [SizedBox(width: 6), Text('Başlangıç',style: TextStyle(color: Color(0xFFFF5722)),)],
              ),
              items: const [
            DropdownMenuItem(
                  value: "baslangic",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.signal_cellular_alt_1_bar,
                        color: Color(0xFFFF5722),
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text('Başlangıç'),
                    ],
                  ),
                ),

                // ORTA
                DropdownMenuItem(
                  value: "orta",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.signal_cellular_alt_2_bar,
                        color: Color(0xFFFF5722),
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text('Orta'),
                    ],
                  ),
                ),

                // İLERİ
                DropdownMenuItem(
                  value: "ileri",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.signal_cellular_alt,
                        color: Color(0xFFFF5722),
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text('İleri'),
                    ],
                  ),
                ),

                // TÜMÜ
                DropdownMenuItem(
                  value: "tumu",
                  child: Row(
                    children: const [
                      Icon(
                        Icons.layers_outlined,
                        color: Color(0xFFFF5722),
                        size: 18,
                      ),
                      SizedBox(width: 10),
                      Text('Tümü'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

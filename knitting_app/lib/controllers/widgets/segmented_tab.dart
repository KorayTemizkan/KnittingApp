import 'package:flutter/material.dart';

class TripleSegmentButton extends StatelessWidget {
  // stateless içindekiler final olmalı
  final List titles;

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const TripleSegmentButton({
    super.key,
    required this.titles,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: List.generate(titles.length, (index) {
          final isSelected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onChanged(index),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  color: isSelected ? Color(0xFFFF5722) : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 16 : 0),
                    bottomLeft: Radius.circular(index == 0 ? 16 : 0),
                    topRight: Radius.circular(
                      index == titles.length - 1 ? 16 : 0,
                    ),
                    bottomRight: Radius.circular(
                      index == titles.length - 1 ? 16 : 0,
                    ),
                  ),
                ),

                child: Text(
                  titles[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

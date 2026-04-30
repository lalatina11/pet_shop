import 'package:flutter/material.dart';

class UserSkeleton extends StatelessWidget {
  const UserSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800] : Colors.grey[300];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        spacing: 20,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(color: baseColor, shape: BoxShape.circle),
          ),
          Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .start,
            spacing: 8,
            children: [
              Container(
                width: 150,
                height: 20,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: 200,
                height: 13,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

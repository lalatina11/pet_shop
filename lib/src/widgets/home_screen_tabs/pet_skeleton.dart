import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Shimmer skeleton untuk satu card pet
// ---------------------------------------------------------------------------
class PetSkeleton extends StatefulWidget {
  const PetSkeleton();

  @override
  State<PetSkeleton> createState() => PetSkeletonState();
}

class PetSkeletonState extends State<PetSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _box({
    double width = double.infinity,
    double height = 12,
    double radius = 8,
  }) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar placeholder
            AnimatedBuilder(
              animation: _animation,
              builder: (_, __) => Opacity(
                opacity: _animation.value,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Teks placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(width: 120, height: 14),
                  const SizedBox(height: 8),
                  _box(width: 180, height: 11),
                  const SizedBox(height: 6),
                  _box(width: 80, height: 11),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Harga placeholder
            _box(width: 70, height: 13),
          ],
        ),
      ),
    );
  }
}

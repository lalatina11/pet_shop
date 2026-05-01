import 'package:flutter/material.dart';

class PetSkeleton extends StatefulWidget {
  const PetSkeleton({super.key});

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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            // Gambar placeholder — sama persis dengan ClipRRect di PetCard
            AnimatedBuilder(
              animation: _animation,
              builder: (_, __) => Opacity(
                opacity: _animation.value,
                child: Container(
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // "Jenis: ..." placeholder
            Align(
              alignment: Alignment.centerLeft,
              child: _box(width: 160, height: 14),
            ),

            // "Gender: ..." placeholder
            Align(
              alignment: Alignment.centerLeft,
              child: _box(width: 110, height: 14),
            ),

            // "Harga: ..." placeholder
            Align(
              alignment: Alignment.centerLeft,
              child: _box(width: 130, height: 14),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../design_system/tokens/app_colors.dart';

class FloatingElements extends StatelessWidget {
  const FloatingElements({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Floating Bubbles
        Positioned(
          top: size.height * 0.1,
          left: size.width * 0.1,
          child: _FloatingBubble(
            size: 20,
            color: Colors.white.withOpacity(0.1),
            delay: 0,
          ),
        ),
        Positioned(
          top: size.height * 0.3,
          right: size.width * 0.2,
          child: _FloatingBubble(
            size: 15,
            color: AppColors.tertiaryGold300.withOpacity(0.2),
            delay: 1000,
          ),
        ),
        Positioned(
          bottom: size.height * 0.4,
          left: size.width * 0.05,
          child: _FloatingBubble(
            size: 25,
            color: Colors.white.withOpacity(0.08),
            delay: 2000,
          ),
        ),
        Positioned(
          top: size.height * 0.6,
          right: size.width * 0.1,
          child: _FloatingBubble(
            size: 18,
            color: AppColors.secondaryOrange300.withOpacity(0.15),
            delay: 1500,
          ),
        ),
      ],
    );
  }
}

class _FloatingBubble extends StatelessWidget {
  final double size;
  final Color color;
  final int delay;

  const _FloatingBubble({
    required this.size,
    required this.color,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .moveY(
          begin: 0,
          end: -20,
          duration: 3000.ms,
          delay: delay.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .moveY(
          begin: -20,
          end: 0,
          duration: 3000.ms,
          curve: Curves.easeInOut,
        );
  }
} 
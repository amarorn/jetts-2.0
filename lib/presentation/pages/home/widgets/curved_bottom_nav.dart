import 'package:flutter/material.dart';

class CurvedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<IconData> icons;

  const CurvedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        children: [
          // Curva desenhada
          Positioned.fill(
            child: CustomPaint(
              painter: _NavBarPainter(selectedIndex: currentIndex, itemCount: icons.length),
            ),
          ),
          // Ícones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (index) {
              final isSelected = index == currentIndex;
              return GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: EdgeInsets.only(top: isSelected ? 0 : 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            icons[index],
                            color: Theme.of(context).primaryColor,
                            size: 28,
                          ),
                        )
                      else
                        Icon(
                          icons[index],
                          color: Colors.white70,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _NavBarPainter extends CustomPainter {
  final int selectedIndex;
  final int itemCount;

  _NavBarPainter({required this.selectedIndex, required this.itemCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF2196F3); // Cor da barra
    final double width = size.width;
    final double height = size.height;
    final double itemWidth = width / itemCount;
    final double centerX = itemWidth * (selectedIndex + 0.5);

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(centerX - 36, 0)
      ..quadraticBezierTo(centerX, 60, centerX + 36, 0)
      ..lineTo(width, 0)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 
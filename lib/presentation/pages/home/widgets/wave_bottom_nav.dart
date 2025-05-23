import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class WaveBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  const WaveBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        // Onda de fundo
        SizedBox(
          height: 70,
          width: double.infinity,
          child: WaveWidget(
            config: CustomConfig(
              gradients: [
                [Color(0xFF2196F3), Color(0xFF21CBF3)],
                [Color(0xFF21CBF3), Color(0xFF2196F3)],
              ],
              durations: [3500, 1944],
              heightPercentages: [0.60, 0.65],
              blur: MaskFilter.blur(BlurStyle.solid, 2),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            waveAmplitude: 0,
            size: const Size(double.infinity, 70),
          ),
        ),
        // Ícones
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final item = items[index];
              final selected = index == currentIndex;
              return GestureDetector(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      selected ? item.selectedIcon : item.icon,
                      color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                      size: selected ? 30 : 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  const NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
} 
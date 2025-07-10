import 'package:flutter/material.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import 'owner_chat_screen.dart';

class OwnerBookingsScreen extends StatefulWidget {
  const OwnerBookingsScreen({super.key});

  @override
  State<OwnerBookingsScreen> createState() => _OwnerBookingsScreenState();
}

class _OwnerBookingsScreenState extends State<OwnerBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlue900,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Text(
                  'Solicitações Pendentes',
                  style: AppTypography.titleLarge
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '3 novas',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBookingCard(
              name: 'Ana Costa',
              boat: 'Iate Premium Deluxe',
              date: '28-30 Jun 2025',
              people: '8 pessoas',
              value: 'R\$ 4.500',
              occasion: 'Festa de aniversário',
              isNew: true,
            ),
            const SizedBox(height: 16),
            _buildBookingCard(
              name: 'Carlos Mendes',
              boat: 'Lancha Speedboat',
              date: '01 Jul 2025',
              people: '4 pessoas',
              value: 'R\$ 1.200',
              occasion: '',
              isNew: true,
            ),
            const SizedBox(height: 32),
            Text(
              'Aprovadas Recentemente',
              style: AppTypography.titleLarge
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildBookingCard(
              name: 'Paula Lima',
              boat: 'Jet Ski',
              date: '10 Jun 2025',
              people: '2 pessoas',
              value: 'R\$ 600',
              occasion: 'Passeio',
              isNew: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard({
    required String name,
    required String boat,
    required String date,
    required String people,
    required String value,
    required String occasion,
    required bool isNew,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue900.withOpacity(0.85),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: isNew ? 18 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                Text(
                  boat,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryBlue100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        color: AppColors.primaryBlue200, size: 20),
                    const SizedBox(width: 6),
                    Text('Data:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue200)),
                    const SizedBox(width: 4),
                    Text(date,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                    const SizedBox(width: 16),
                    Icon(Icons.people_alt_rounded,
                        color: AppColors.secondaryOrange400, size: 20),
                    const SizedBox(width: 6),
                    Text('Pessoas:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryOrange400)),
                    const SizedBox(width: 4),
                    Text(people,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.attach_money_rounded,
                        color: AppColors.success500, size: 20),
                    const SizedBox(width: 6),
                    Text('Valor:',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.success500)),
                    const SizedBox(width: 4),
                    Text(value,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.greenAccent,
                            fontSize: 16)),
                  ],
                ),
                if (occasion.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.celebration_rounded,
                          color: AppColors.tertiaryGold500, size: 20),
                      const SizedBox(width: 6),
                      Text('Ocasião:',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.tertiaryGold500)),
                      const SizedBox(width: 4),
                      Text(occasion,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  ),
                ],
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check, size: 20),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        label: const Text('Aprovar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OwnerChatScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline_rounded,
                            size: 20),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryOrange500,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        label: const Text('Chat'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.close, size: 20),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        label: const Text('Recusar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isNew)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'NOVA',
                  style: TextStyle(
                    color: AppColors.primaryBlue700,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

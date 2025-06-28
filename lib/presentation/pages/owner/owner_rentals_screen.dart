import 'package:flutter/material.dart';
import '../../../design_system/tokens/app_colors.dart';
import '../../../design_system/tokens/app_typography.dart';

class OwnerRentalsScreen extends StatelessWidget {
  const OwnerRentalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlue900,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Meus Aluguéis',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            _buildRentalCard(
              boat: 'Iate Premium Deluxe',
              client: 'Ana Costa',
              date: '28-30 Jun 2025',
              value: 'R\$ 4.500',
              status: 'Aprovado',
              statusColor: AppColors.success500,
            ),
            _buildRentalCard(
              boat: 'Lancha Speedboat',
              client: 'Carlos Mendes',
              date: '01 Jul 2025',
              value: 'R\$ 1.200',
              status: 'Pendente',
              statusColor: AppColors.warning500,
            ),
            _buildRentalCard(
              boat: 'Jet Ski',
              client: 'Paula Lima',
              date: '10 Jun 2025',
              value: 'R\$ 600',
              status: 'Cancelado',
              statusColor: AppColors.error500,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentalCard({
    required String boat,
    required String client,
    required String date,
    required String value,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue900.withOpacity(0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.directions_boat_rounded,
                  color: AppColors.primaryBlue100, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  boat,
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.person, color: AppColors.primaryBlue100, size: 20),
              const SizedBox(width: 6),
              Text('Cliente:',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Text(client, style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today_rounded,
                  color: AppColors.primaryBlue100, size: 20),
              const SizedBox(width: 6),
              Text('Data:',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Text(date, style: const TextStyle(color: Colors.white)),
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
                      color: AppColors.success500,
                      fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Text(value,
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

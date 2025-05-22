import 'package:flutter/material.dart';
import '../../../services/notification_service.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';

class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste de Notificações'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Push Notifications',
              style: AppTypography.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildTestButton(
              context,
              'Confirmação de Reserva',
              () async {
                await NotificationService().sendBookingConfirmation(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  DateTime.now().add(const Duration(days: 7)),
                );
              },
            ),
            _buildTestButton(
              context,
              'Lembrete de Viagem',
              () async {
                await NotificationService().sendTripReminder(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  DateTime.now().add(const Duration(days: 7)),
                );
              },
            ),
            _buildTestButton(
              context,
              'Alerta Meteorológico',
              () async {
                await NotificationService().sendWeatherAlert(
                  'Angra dos Reis',
                  'Sol com nuvens, temperatura 28°C, ventos de 15km/h',
                );
              },
            ),
            _buildTestButton(
              context,
              'Oferta Personalizada',
              () async {
                await NotificationService().sendPersonalizedOffer(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Desconto de 20% em sua próxima reserva! Válido até o final do mês.',
                );
              },
            ),
            _buildTestButton(
              context,
              'Update da Embarcação',
              () async {
                await NotificationService().sendBoatUpdate(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Nova manutenção realizada. Sua embarcação está pronta para navegar!',
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'In-App Notifications',
              style: AppTypography.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildTestButton(
              context,
              'Mensagem do Proprietário',
              () async {
                await NotificationService().sendOwnerMessage(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Olá! Gostaria de confirmar se você tem alguma preferência especial para sua próxima viagem.',
                );
              },
            ),
            _buildTestButton(
              context,
              'Atualização de Status',
              () async {
                await NotificationService().sendStatusUpdate(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Sua reserva foi atualizada para o status: Confirmada',
                );
              },
            ),
            _buildTestButton(
              context,
              'Novidades do App',
              () async {
                await NotificationService().sendAppNews(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Nova funcionalidade: Agora você pode dividir o pagamento com seus amigos!',
                );
              },
            ),
            _buildTestButton(
              context,
              'Alerta de Segurança',
              () async {
                await NotificationService().sendSafetyAlert(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Alerta: Condições climáticas adversas previstas para amanhã. Recomendamos reagendar sua viagem.',
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Ações em Lote',
              style: AppTypography.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildTestButton(
              context,
              'Enviar Todas as Notificações',
              () async {
                // Envia todas as notificações com um pequeno delay entre elas
                await NotificationService().sendBookingConfirmation(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  DateTime.now().add(const Duration(days: 7)),
                );
                await Future.delayed(const Duration(seconds: 1));

                await NotificationService().sendTripReminder(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  DateTime.now().add(const Duration(days: 7)),
                );
                await Future.delayed(const Duration(seconds: 1));

                await NotificationService().sendWeatherAlert(
                  'Angra dos Reis',
                  'Sol com nuvens, temperatura 28°C',
                );
                await Future.delayed(const Duration(seconds: 1));

                await NotificationService().sendPersonalizedOffer(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Desconto de 20% em sua próxima reserva!',
                );
                await Future.delayed(const Duration(seconds: 1));

                await NotificationService().sendBoatUpdate(
                  'TEST_${DateTime.now().millisecondsSinceEpoch}',
                  'Nova manutenção realizada em sua embarcação.',
                );
              },
            ),
            _buildTestButton(
              context,
              'Limpar Todas as Notificações',
              () async {
                await NotificationService().cancelAllNotifications();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Todas as notificações foram removidas'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
        ),
        child: Text(label),
      ),
    );
  }
} 
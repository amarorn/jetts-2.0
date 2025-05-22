import 'package:flutter/material.dart';
import '../../../domain/models/notification_model.dart';
import '../../../design_system/tokens/app_spacing.dart';
import '../../../design_system/tokens/app_typography.dart';
import '../../../design_system/tokens/app_radius.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    // Simulação de carregamento de notificações
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _notifications = [
        NotificationModel(
          id: '1',
          title: 'Reserva Confirmada!',
          message: 'Sua reserva para 15/03/2024 foi confirmada com sucesso.',
          type: NotificationType.bookingConfirmation,
          priority: NotificationPriority.high,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        NotificationModel(
          id: '2',
          title: 'Lembrete de Viagem',
          message: 'Sua viagem está chegando! Prepare-se para embarcar em 15/03/2024.',
          type: NotificationType.tripReminder,
          priority: NotificationPriority.medium,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        NotificationModel(
          id: '3',
          title: 'Alerta Meteorológico',
          message: 'Condições climáticas em Angra dos Reis: Sol com nuvens, temperatura 28°C.',
          type: NotificationType.weatherAlert,
          priority: NotificationPriority.high,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        NotificationModel(
          id: '4',
          title: 'Oferta Especial!',
          message: 'Desconto de 20% em sua próxima reserva!',
          type: NotificationType.personalizedOffer,
          priority: NotificationPriority.medium,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        NotificationModel(
          id: '5',
          title: 'Atualização da Embarcação',
          message: 'Nova manutenção realizada em sua embarcação.',
          type: NotificationType.boatUpdate,
          priority: NotificationPriority.medium,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              setState(() {
                _notifications.clear();
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 64,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Nenhuma notificação',
                        style: AppTypography.titleMedium.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];
                    return Dismissible(
                      key: Key(notification.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: AppSpacing.lg),
                        color: theme.colorScheme.error,
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          _notifications.removeAt(index);
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(AppSpacing.md),
                          leading: CircleAvatar(
                            backgroundColor: notification.priorityColor.withOpacity(0.1),
                            child: Icon(
                              notification.icon,
                              color: notification.priorityColor,
                            ),
                          ),
                          title: Text(
                            notification.title,
                            style: AppTypography.titleSmall,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                notification.message,
                                style: AppTypography.bodyMedium,
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                _formatDate(notification.createdAt),
                                style: AppTypography.bodySmall.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                          trailing: notification.isRead
                              ? null
                              : Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                          onTap: () {
                            // Implementar navegação baseada no tipo de notificação
                            debugPrint('Notificação tocada: ${notification.id}');
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos atrás';
    } else {
      return 'Agora mesmo';
    }
  }
} 
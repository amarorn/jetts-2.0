import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../domain/models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  final _notificationChannel = const AndroidNotificationChannel(
    'jets_channel',
    'Jetts Notifications',
    description: 'Canal de notificações do Jetts',
    importance: Importance.high,
  );

  Future<void> initialize() async {
    tz.initializeTimeZones();
    
    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_notificationChannel);
  }

  Future<void> _onNotificationTap(NotificationResponse response) async {
    // Implementar navegação baseada no payload da notificação
    debugPrint('Notificação tocada: ${response.payload}');
  }

  Future<void> showNotification(NotificationModel notification) async {
    final androidDetails = AndroidNotificationDetails(
      _notificationChannel.id,
      _notificationChannel.name,
      channelDescription: _notificationChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      color: notification.priorityColor,
      icon: '@mipmap/launcher_icon',
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.show(
      notification.id.hashCode,
      notification.title,
      notification.message,
      details,
      payload: notification.data?.toString(),
    );
  }

  Future<void> scheduleNotification(NotificationModel notification) async {
    if (notification.expiresAt == null) return;

    final androidDetails = AndroidNotificationDetails(
      _notificationChannel.id,
      _notificationChannel.name,
      channelDescription: _notificationChannel.description,
      importance: Importance.high,
      priority: Priority.high,
      color: notification.priorityColor,
      icon: '@mipmap/launcher_icon',
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notifications.zonedSchedule(
      notification.id.hashCode,
      notification.title,
      notification.message,
      tz.TZDateTime.from(notification.expiresAt!, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: notification.data?.toString(),
    );
  }

  Future<void> cancelNotification(String id) async {
    await _notifications.cancel(id.hashCode);
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  // Métodos específicos para cada tipo de notificação
  Future<void> sendBookingConfirmation(String bookingId, DateTime date) async {
    final notification = NotificationModel(
      id: 'booking_$bookingId',
      title: 'Reserva Confirmada!',
      message: 'Sua reserva para ${date.toString()} foi confirmada com sucesso.',
      type: NotificationType.bookingConfirmation,
      priority: NotificationPriority.high,
      createdAt: DateTime.now(),
      data: {'bookingId': bookingId},
    );
    await showNotification(notification);
  }

  Future<void> sendTripReminder(String bookingId, DateTime date) async {
    final notification = NotificationModel(
      id: 'reminder_$bookingId',
      title: 'Lembrete de Viagem',
      message: 'Sua viagem está chegando! Prepare-se para embarcar em ${date.toString()}.',
      type: NotificationType.tripReminder,
      priority: NotificationPriority.medium,
      createdAt: DateTime.now(),
      expiresAt: date.subtract(const Duration(days: 1)),
      data: {'bookingId': bookingId},
    );
    await scheduleNotification(notification);
  }

  Future<void> sendWeatherAlert(String location, String condition) async {
    final notification = NotificationModel(
      id: 'weather_${DateTime.now().millisecondsSinceEpoch}',
      title: 'Alerta Meteorológico',
      message: 'Condições climáticas em $location: $condition',
      type: NotificationType.weatherAlert,
      priority: NotificationPriority.high,
      createdAt: DateTime.now(),
      data: {'location': location, 'condition': condition},
    );
    await showNotification(notification);
  }

  Future<void> sendPersonalizedOffer(String offerId, String description) async {
    final notification = NotificationModel(
      id: 'offer_$offerId',
      title: 'Oferta Especial!',
      message: description,
      type: NotificationType.personalizedOffer,
      priority: NotificationPriority.medium,
      createdAt: DateTime.now(),
      data: {'offerId': offerId},
    );
    await showNotification(notification);
  }

  Future<void> sendBoatUpdate(String boatId, String update) async {
    final notification = NotificationModel(
      id: 'boat_$boatId',
      title: 'Atualização da Embarcação',
      message: update,
      type: NotificationType.boatUpdate,
      priority: NotificationPriority.medium,
      createdAt: DateTime.now(),
      data: {'boatId': boatId},
    );
    await showNotification(notification);
  }

  Future<void> sendOwnerMessage(String messageId, String message) async {
    final notification = NotificationModel(
      id: 'message_$messageId',
      title: 'Mensagem do Proprietário',
      message: message,
      type: NotificationType.ownerMessage,
      priority: NotificationPriority.medium,
      createdAt: DateTime.now(),
      data: {'messageId': messageId},
    );
    await showNotification(notification);
  }

  Future<void> sendStatusUpdate(String bookingId, String status) async {
    final notification = NotificationModel(
      id: 'status_$bookingId',
      title: 'Atualização de Status',
      message: status,
      type: NotificationType.statusUpdate,
      priority: NotificationPriority.medium,
      createdAt: DateTime.now(),
      data: {'bookingId': bookingId},
    );
    await showNotification(notification);
  }

  Future<void> sendAppNews(String newsId, String news) async {
    final notification = NotificationModel(
      id: 'news_$newsId',
      title: 'Novidades do App',
      message: news,
      type: NotificationType.appNews,
      priority: NotificationPriority.low,
      createdAt: DateTime.now(),
      data: {'newsId': newsId},
    );
    await showNotification(notification);
  }

  Future<void> sendSafetyAlert(String alertId, String alert) async {
    final notification = NotificationModel(
      id: 'safety_$alertId',
      title: 'Alerta de Segurança',
      message: alert,
      type: NotificationType.safetyAlert,
      priority: NotificationPriority.urgent,
      createdAt: DateTime.now(),
      data: {'alertId': alertId},
    );
    await showNotification(notification);
  }
} 
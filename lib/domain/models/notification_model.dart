import 'package:flutter/material.dart';

enum NotificationType {
  bookingConfirmation,
  tripReminder,
  weatherAlert,
  personalizedOffer,
  boatUpdate,
  ownerMessage,
  statusUpdate,
  appNews,
  safetyAlert,
}

enum NotificationPriority {
  low,
  medium,
  high,
  urgent,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final NotificationPriority priority;
  final DateTime createdAt;
  final DateTime? expiresAt;
  final Map<String, dynamic>? data;
  final bool isRead;
  final String? imageUrl;
  final String? actionUrl;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.priority = NotificationPriority.medium,
    required this.createdAt,
    this.expiresAt,
    this.data,
    this.isRead = false,
    this.imageUrl,
    this.actionUrl,
  });

  IconData get icon {
    switch (type) {
      case NotificationType.bookingConfirmation:
        return Icons.confirmation_number;
      case NotificationType.tripReminder:
        return Icons.event;
      case NotificationType.weatherAlert:
        return Icons.cloud;
      case NotificationType.personalizedOffer:
        return Icons.local_offer;
      case NotificationType.boatUpdate:
        return Icons.directions_boat;
      case NotificationType.ownerMessage:
        return Icons.message;
      case NotificationType.statusUpdate:
        return Icons.update;
      case NotificationType.appNews:
        return Icons.new_releases;
      case NotificationType.safetyAlert:
        return Icons.warning;
    }
  }

  Color get priorityColor {
    switch (priority) {
      case NotificationPriority.low:
        return Colors.grey;
      case NotificationPriority.medium:
        return Colors.blue;
      case NotificationPriority.high:
        return Colors.orange;
      case NotificationPriority.urgent:
        return Colors.red;
    }
  }
} 
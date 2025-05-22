import 'package:flutter/material.dart';

enum PaymentMethod {
  creditCard,
  debitCard,
  pix,
  bankTransfer,
}

class PaymentSplit {
  final String name;
  final String email;
  final double amount;
  final bool isPaid;

  PaymentSplit({
    required this.name,
    required this.email,
    required this.amount,
    this.isPaid = false,
  });
}

class AddOn {
  final String id;
  final String name;
  final String description;
  final double price;
  final IconData icon;
  bool isSelected;

  AddOn({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    this.isSelected = false,
  });
}

class Insurance {
  final String id;
  final String name;
  final String description;
  final double price;
  final double coverage;
  bool isSelected;

  Insurance({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.coverage,
    this.isSelected = false,
  });
}

class Coupon {
  final String code;
  final String description;
  final double discount;
  final DateTime expiryDate;
  final bool isPercentage;

  Coupon({
    required this.code,
    required this.description,
    required this.discount,
    required this.expiryDate,
    this.isPercentage = false,
  });
} 
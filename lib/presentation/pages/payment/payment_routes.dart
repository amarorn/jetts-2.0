import 'package:flutter/material.dart';
import 'package:jetts_2_0/presentation/pages/payment/payment_page.dart';

class PaymentRoutes {
  static const String payment = '/payment';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      payment: (context) => const PaymentPage(),
    };
  }
} 
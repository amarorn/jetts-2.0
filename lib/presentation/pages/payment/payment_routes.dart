import 'payment_page.dart';
import 'payment_card_page.dart';
import 'payment_pix_page.dart';

class PaymentRoutes {
  static const String payment = '/payment';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      payment: (context) => const PaymentPage(),
      '/payment-card': (context) => const PaymentCardPage(),
      '/payment-pix': (context) => const PaymentPixPage(),
    };
  }
} 
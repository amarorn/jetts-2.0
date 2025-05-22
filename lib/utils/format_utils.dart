import 'package:intl/intl.dart';

class FormatUtils {
  static String formatPrice(double value) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return format.format(value);
  }

  static String formatPeople(int people) {
    return people == 1 ? '1 pessoa' : '$people pessoas';
  }

  static String formatRating(double rating) {
    return rating.toStringAsFixed(1).replaceAll('.', ',');
  }
} 
enum PricingRule {
  weekday,
  weekend,
  holiday,
  highSeason,
  lowSeason,
  longTermDiscount,
  lastMinute,
  earlyBird,
}

enum SeasonType {
  high,
  medium,
  low,
}

class PricingConfiguration {
  final String boatId;
  final double basePrice;
  final Map<PricingRule, double> multipliers;
  final Map<int, double> durationDiscounts; // dias -> desconto %
  final List<CustomPriceRule> customRules;
  final bool isAutomaticPricingEnabled;

  PricingConfiguration({
    required this.boatId,
    required this.basePrice,
    required this.multipliers,
    required this.durationDiscounts,
    required this.customRules,
    required this.isAutomaticPricingEnabled,
  });

  double calculatePrice(DateTime date, int durationDays) {
    if (!isAutomaticPricingEnabled) return basePrice;

    double finalPrice = basePrice;

    // Aplicar regras por data
    final dayOfWeek = date.weekday;
    if (dayOfWeek >= 6) { // Sábado ou Domingo
      finalPrice *= (multipliers[PricingRule.weekend] ?? 1.0);
    } else {
      finalPrice *= (multipliers[PricingRule.weekday] ?? 1.0);
    }

    // Verificar se é feriado
    if (_isHoliday(date)) {
      finalPrice *= (multipliers[PricingRule.holiday] ?? 1.0);
    }

    // Aplicar regras de temporada
    final season = _getSeason(date);
    switch (season) {
      case SeasonType.high:
        finalPrice *= (multipliers[PricingRule.highSeason] ?? 1.0);
        break;
      case SeasonType.low:
        finalPrice *= (multipliers[PricingRule.lowSeason] ?? 1.0);
        break;
      case SeasonType.medium:
        // Sem alteração
        break;
    }

    // Aplicar desconto por duração
    if (durationDays > 1) {
      final discount = _getDurationDiscount(durationDays);
      finalPrice *= (1.0 - discount);
    }

    // Aplicar regras customizadas
    for (final rule in customRules) {
      if (rule.appliesTo(date, durationDays)) {
        finalPrice *= rule.multiplier;
      }
    }

    return finalPrice;
  }

  bool _isHoliday(DateTime date) {
    // Lista simplificada de feriados brasileiros
    final holidays = [
      DateTime(date.year, 1, 1),   // Ano Novo
      DateTime(date.year, 4, 21),  // Tiradentes
      DateTime(date.year, 9, 7),   // Independência
      DateTime(date.year, 10, 12), // Nossa Senhora Aparecida
      DateTime(date.year, 11, 2),  // Finados
      DateTime(date.year, 11, 15), // Proclamação da República
      DateTime(date.year, 12, 25), // Natal
    ];

    return holidays.any((holiday) => 
      holiday.day == date.day && holiday.month == date.month);
  }

  SeasonType _getSeason(DateTime date) {
    final month = date.month;
    
    // Alta temporada: Dezembro, Janeiro, Fevereiro, Julho
    if ([12, 1, 2, 7].contains(month)) {
      return SeasonType.high;
    }
    
    // Baixa temporada: Março, Abril, Maio, Agosto, Setembro
    if ([3, 4, 5, 8, 9].contains(month)) {
      return SeasonType.low;
    }
    
    // Temporada média: Junho, Outubro, Novembro
    return SeasonType.medium;
  }

  double _getDurationDiscount(int days) {
    // Encontrar o maior desconto aplicável
    double maxDiscount = 0.0;
    
    for (final entry in durationDiscounts.entries) {
      if (days >= entry.key && entry.value > maxDiscount) {
        maxDiscount = entry.value;
      }
    }
    
    return maxDiscount / 100; // Converter porcentagem para decimal
  }
}

class CustomPriceRule {
  final String id;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<int>? applicableDays; // 1-7 (Segunda a Domingo)
  final int? minDuration;
  final int? maxDuration;
  final double multiplier;
  final bool isActive;

  CustomPriceRule({
    required this.id,
    required this.name,
    this.startDate,
    this.endDate,
    this.applicableDays,
    this.minDuration,
    this.maxDuration,
    required this.multiplier,
    required this.isActive,
  });

  bool appliesTo(DateTime date, int durationDays) {
    if (!isActive) return false;

    // Verificar período
    if (startDate != null && date.isBefore(startDate!)) return false;
    if (endDate != null && date.isAfter(endDate!)) return false;

    // Verificar dia da semana
    if (applicableDays != null && !applicableDays!.contains(date.weekday)) {
      return false;
    }

    // Verificar duração
    if (minDuration != null && durationDays < minDuration!) return false;
    if (maxDuration != null && durationDays > maxDuration!) return false;

    return true;
  }
}

class PriceQuote {
  final DateTime date;
  final int durationDays;
  final double basePrice;
  final double finalPrice;
  final List<PriceAdjustment> adjustments;
  final DateTime calculatedAt;

  PriceQuote({
    required this.date,
    required this.durationDays,
    required this.basePrice,
    required this.finalPrice,
    required this.adjustments,
    required this.calculatedAt,
  });

  double get totalDiscount => basePrice - finalPrice;
  double get discountPercentage => 
      totalDiscount > 0 ? (totalDiscount / basePrice) * 100 : 0.0;
  bool get hasDiscount => totalDiscount > 0;
  bool get hasSurcharge => finalPrice > basePrice;
}

class PriceAdjustment {
  final String reason;
  final double amount;
  final bool isPercentage;
  final PricingRule? rule;

  PriceAdjustment({
    required this.reason,
    required this.amount,
    required this.isPercentage,
    this.rule,
  });

  String get displayText {
    final sign = amount >= 0 ? '+' : '';
    final value = isPercentage ? '${amount.toStringAsFixed(1)}%' : 
                                'R\$ ${amount.toStringAsFixed(2)}';
    return '$reason: $sign$value';
  }
}

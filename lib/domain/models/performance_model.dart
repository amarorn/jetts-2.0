class PerformanceMetrics {
  final double totalRevenue;
  final double monthlyRevenue;
  final int totalBookings;
  final int monthlyBookings;
  final double occupancyRate;
  final double averageRating;
  final int totalReviews;
  final int profileViews;
  final int monthlyViews;
  final List<MonthlyData> revenueHistory;
  final List<MonthlyData> bookingHistory;

  PerformanceMetrics({
    required this.totalRevenue,
    required this.monthlyRevenue,
    required this.totalBookings,
    required this.monthlyBookings,
    required this.occupancyRate,
    required this.averageRating,
    required this.totalReviews,
    required this.profileViews,
    required this.monthlyViews,
    required this.revenueHistory,
    required this.bookingHistory,
  });

  double get revenueGrowthRate {
    if (revenueHistory.length < 2) return 0.0;
    final current = revenueHistory.last.value;
    final previous = revenueHistory[revenueHistory.length - 2].value;
    if (previous == 0) return 0.0;
    return ((current - previous) / previous) * 100;
  }

  double get bookingGrowthRate {
    if (bookingHistory.length < 2) return 0.0;
    final current = bookingHistory.last.value;
    final previous = bookingHistory[bookingHistory.length - 2].value;
    if (previous == 0) return 0.0;
    return ((current - previous) / previous) * 100;
  }
}

class MonthlyData {
  final String month;
  final double value;
  final DateTime date;

  MonthlyData({
    required this.month,
    required this.value,
    required this.date,
  });
}

class BoatPerformance {
  final String boatId;
  final String boatName;
  final double revenue;
  final int bookings;
  final double rating;
  final int views;
  final double occupancyRate;

  BoatPerformance({
    required this.boatId,
    required this.boatName,
    required this.revenue,
    required this.bookings,
    required this.rating,
    required this.views,
    required this.occupancyRate,
  });
}

class RecentActivity {
  final String id;
  final ActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? boatName;
  final double? amount;

  RecentActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.boatName,
    this.amount,
  });
}

enum ActivityType {
  newBooking,
  paymentReceived,
  reviewReceived,
  profileView,
  bookingCancelled,
  messageReceived,
}

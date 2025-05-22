class BoatModel {
  final String id;
  final String name;
  final String location;
  final double price;
  final double rating;
  final String imageUrl;
  final List<String> features;
  final List<DateTime> unavailableDates;
  final Map<DateTime, double> dynamicPrices;
  final int? discount;
  final String? status;
  final String? date;

  BoatModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.features,
    this.unavailableDates = const [],
    this.dynamicPrices = const {},
    this.discount,
    this.status,
    this.date,
  });
} 
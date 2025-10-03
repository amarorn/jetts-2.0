enum ReviewCriteria {
  cleanliness,
  communication,
  accuracy,
  location,
  value,
  overall,
}

class DetailedReview {
  final String id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String boatId;
  final String boatName;
  final Map<ReviewCriteria, double> ratings;
  final String comment;
  final List<String> photos;
  final DateTime createdAt;
  final bool isVerified;
  final String? tripDate;
  final List<String> highlights;
  final List<String> improvements;

  DetailedReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.boatId,
    required this.boatName,
    required this.ratings,
    required this.comment,
    required this.photos,
    required this.createdAt,
    required this.isVerified,
    this.tripDate,
    required this.highlights,
    required this.improvements,
  });

  double get overallRating {
    if (ratings.isEmpty) return 0.0;
    final sum = ratings.values.reduce((a, b) => a + b);
    return sum / ratings.length;
  }

  bool get hasPhotos => photos.isNotEmpty;
  
  bool get isRecent {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    return difference.inDays <= 30;
  }

  DetailedReview copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? boatId,
    String? boatName,
    Map<ReviewCriteria, double>? ratings,
    String? comment,
    List<String>? photos,
    DateTime? createdAt,
    bool? isVerified,
    String? tripDate,
    List<String>? highlights,
    List<String>? improvements,
  }) {
    return DetailedReview(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      boatId: boatId ?? this.boatId,
      boatName: boatName ?? this.boatName,
      ratings: ratings ?? this.ratings,
      comment: comment ?? this.comment,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
      tripDate: tripDate ?? this.tripDate,
      highlights: highlights ?? this.highlights,
      improvements: improvements ?? this.improvements,
    );
  }
}

class ReviewSummary {
  final double overallRating;
  final int totalReviews;
  final Map<ReviewCriteria, double> averageRatings;
  final Map<int, int> ratingDistribution; // 1-5 stars -> count
  final List<String> mostMentionedHighlights;
  final List<String> mostMentionedImprovements;
  final double recommendationRate;

  ReviewSummary({
    required this.overallRating,
    required this.totalReviews,
    required this.averageRatings,
    required this.ratingDistribution,
    required this.mostMentionedHighlights,
    required this.mostMentionedImprovements,
    required this.recommendationRate,
  });

  int get fiveStarCount => ratingDistribution[5] ?? 0;
  int get fourStarCount => ratingDistribution[4] ?? 0;
  int get threeStarCount => ratingDistribution[3] ?? 0;
  int get twoStarCount => ratingDistribution[2] ?? 0;
  int get oneStarCount => ratingDistribution[1] ?? 0;

  double getStarPercentage(int stars) {
    if (totalReviews == 0) return 0.0;
    final count = ratingDistribution[stars] ?? 0;
    return (count / totalReviews) * 100;
  }
}

extension ReviewCriteriaExtension on ReviewCriteria {
  String get displayName {
    switch (this) {
      case ReviewCriteria.cleanliness:
        return 'Limpeza';
      case ReviewCriteria.communication:
        return 'Comunicação';
      case ReviewCriteria.accuracy:
        return 'Precisão do Anúncio';
      case ReviewCriteria.location:
        return 'Localização';
      case ReviewCriteria.value:
        return 'Custo-Benefício';
      case ReviewCriteria.overall:
        return 'Geral';
    }
  }

  String get description {
    switch (this) {
      case ReviewCriteria.cleanliness:
        return 'Quão limpo estava o barco?';
      case ReviewCriteria.communication:
        return 'Como foi a comunicação com o proprietário?';
      case ReviewCriteria.accuracy:
        return 'O barco estava conforme o anúncio?';
      case ReviewCriteria.location:
        return 'Como foi a localização e acesso?';
      case ReviewCriteria.value:
        return 'Vale o preço cobrado?';
      case ReviewCriteria.overall:
        return 'Avaliação geral da experiência';
    }
  }
}

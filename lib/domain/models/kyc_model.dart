enum KYCStatus {
  notStarted,
  inProgress,
  underReview,
  approved,
  rejected,
}

enum DocumentType {
  cpf,
  rg,
  cnh,
  passport,
}

class KYCDocument {
  final String id;
  final DocumentType type;
  final String documentNumber;
  final String frontImagePath;
  final String? backImagePath;
  final DateTime uploadedAt;
  final KYCStatus status;
  final String? rejectionReason;

  KYCDocument({
    required this.id,
    required this.type,
    required this.documentNumber,
    required this.frontImagePath,
    this.backImagePath,
    required this.uploadedAt,
    required this.status,
    this.rejectionReason,
  });

  KYCDocument copyWith({
    String? id,
    DocumentType? type,
    String? documentNumber,
    String? frontImagePath,
    String? backImagePath,
    DateTime? uploadedAt,
    KYCStatus? status,
    String? rejectionReason,
  }) {
    return KYCDocument(
      id: id ?? this.id,
      type: type ?? this.type,
      documentNumber: documentNumber ?? this.documentNumber,
      frontImagePath: frontImagePath ?? this.frontImagePath,
      backImagePath: backImagePath ?? this.backImagePath,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }
}

class KYCProfile {
  final String userId;
  final String fullName;
  final String email;
  final String phone;
  final DateTime? birthDate;
  final String? address;
  final List<KYCDocument> documents;
  final KYCStatus overallStatus;
  final DateTime? verifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  KYCProfile({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    this.birthDate,
    this.address,
    required this.documents,
    required this.overallStatus,
    this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isVerified => overallStatus == KYCStatus.approved;
  
  bool get hasAllRequiredDocuments => documents.isNotEmpty;
  
  double get completionPercentage {
    if (documents.isEmpty) return 0.0;
    
    int totalSteps = 4; // Nome, email, telefone, documento
    int completedSteps = 0;
    
    if (fullName.isNotEmpty) completedSteps++;
    if (email.isNotEmpty) completedSteps++;
    if (phone.isNotEmpty) completedSteps++;
    if (documents.isNotEmpty) completedSteps++;
    
    return completedSteps / totalSteps;
  }

  KYCProfile copyWith({
    String? userId,
    String? fullName,
    String? email,
    String? phone,
    DateTime? birthDate,
    String? address,
    List<KYCDocument>? documents,
    KYCStatus? overallStatus,
    DateTime? verifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return KYCProfile(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
      documents: documents ?? this.documents,
      overallStatus: overallStatus ?? this.overallStatus,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

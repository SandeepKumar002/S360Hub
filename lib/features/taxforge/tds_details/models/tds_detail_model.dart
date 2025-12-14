class TaxforgeTdsDetail {
  final String id;
  final String? orgId;
  final String? partyType;
  final String? partyId;
  final String? sectionCode;
  final double? tdsRatePercent;
  final double? thresholdAmount;
  final String? pan;
  final bool? panValidated;
  final String? exemptionCertificate;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final bool? isActive;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  TaxforgeTdsDetail({
    required this.id,
    this.orgId,
    this.partyType,
    this.partyId,
    this.sectionCode,
    this.tdsRatePercent,
    this.thresholdAmount,
    this.pan,
    this.panValidated,
    this.exemptionCertificate,
    this.effectiveFrom,
    this.effectiveTo,
    this.isActive,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.isDeleted,
  });

  factory TaxforgeTdsDetail.fromJson(Map<String, dynamic> json) {
    return TaxforgeTdsDetail(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      partyType: json['party_type'] as String?,
      partyId: json['party_id'] as String?,
      sectionCode: json['section_code'] as String?,
      tdsRatePercent: (json['tds_rate_percent'] as num?)?.toDouble(),
      thresholdAmount: (json['threshold_amount'] as num?)?.toDouble(),
      pan: json['pan'] as String?,
      panValidated: json['pan_validated'] as bool?,
      exemptionCertificate: json['exemption_certificate'] as String?,
      effectiveFrom: json['effective_from'] == null ? null : DateTime.parse(json['effective_from'] as String),
      effectiveTo: json['effective_to'] == null ? null : DateTime.parse(json['effective_to'] as String),
      isActive: json['is_active'] as bool?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
      approvedAt: json['approved_at'] == null ? null : DateTime.parse(json['approved_at'] as String),
      approvedBy: json['approved_by'] as String?,
      deletedAt: json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at'] as String),
      deletedBy: json['deleted_by'] as String?,
      deleteType: json['delete_type'] as String?,
      isDeleted: json['is_deleted'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'party_type': partyType,
      'party_id': partyId,
      'section_code': sectionCode,
      'tds_rate_percent': tdsRatePercent,
      'threshold_amount': thresholdAmount,
      'pan': pan,
      'pan_validated': panValidated,
      'exemption_certificate': exemptionCertificate,
      'effective_from': effectiveFrom?.toIso8601String(),
      'effective_to': effectiveTo?.toIso8601String(),
      'is_active': isActive,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'approved_at': approvedAt?.toIso8601String(),
      'approved_by': approvedBy,
      'deleted_at': deletedAt?.toIso8601String(),
      'deleted_by': deletedBy,
      'delete_type': deleteType,
      'is_deleted': isDeleted,
    };
  }
}

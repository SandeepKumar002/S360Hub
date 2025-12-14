class TaxforgeGstDetail {
  final String id;
  final String? orgId;
  final String? partyType;
  final String? partyId;
  final String? gstin;
  final String? legalName;
  final String? tradeName;
  final String? gstState;
  final String? registrationType;
  final bool? isDefault;
  final String? status;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final String? filingFrequency;
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

  TaxforgeGstDetail({
    required this.id,
    this.orgId,
    this.partyType,
    this.partyId,
    this.gstin,
    this.legalName,
    this.tradeName,
    this.gstState,
    this.registrationType,
    this.isDefault,
    this.status,
    this.effectiveFrom,
    this.effectiveTo,
    this.filingFrequency,
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

  factory TaxforgeGstDetail.fromJson(Map<String, dynamic> json) {
    return TaxforgeGstDetail(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      partyType: json['party_type'] as String?,
      partyId: json['party_id'] as String?,
      gstin: json['gstin'] as String?,
      legalName: json['legal_name'] as String?,
      tradeName: json['trade_name'] as String?,
      gstState: json['gst_state'] as String?,
      registrationType: json['registration_type'] as String?,
      isDefault: json['is_default'] as bool?,
      status: json['status'] as String?,
      effectiveFrom: json['effective_from'] == null ? null : DateTime.parse(json['effective_from'] as String),
      effectiveTo: json['effective_to'] == null ? null : DateTime.parse(json['effective_to'] as String),
      filingFrequency: json['filing_frequency'] as String?,
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
      'gstin': gstin,
      'legal_name': legalName,
      'trade_name': tradeName,
      'gst_state': gstState,
      'registration_type': registrationType,
      'is_default': isDefault,
      'status': status,
      'effective_from': effectiveFrom?.toIso8601String(),
      'effective_to': effectiveTo?.toIso8601String(),
      'filing_frequency': filingFrequency,
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

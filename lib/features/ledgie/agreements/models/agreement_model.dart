class LedgieAgreement {
  final String id;
  final String? orgId;
  final String? entityId;
  final String? agreementType;
  final String? agreementNumber;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? value;
  final String? currency;
  final Map<String, dynamic>? terms;
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

  LedgieAgreement({
    required this.id,
    this.orgId,
    this.entityId,
    this.agreementType,
    this.agreementNumber,
    this.startDate,
    this.endDate,
    this.value,
    this.currency,
    this.terms,
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

  factory LedgieAgreement.fromJson(Map<String, dynamic> json) {
    return LedgieAgreement(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      entityId: json['entity_id'] as String?,
      agreementType: json['agreement_type'] as String?,
      agreementNumber: json['agreement_number'] as String?,
      startDate: json['start_date'] == null ? null : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null ? null : DateTime.parse(json['end_date'] as String),
      value: (json['value'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      terms: json['terms'] as Map<String, dynamic>? ?? {},
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
      'entity_id': entityId,
      'agreement_type': agreementType,
      'agreement_number': agreementNumber,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'value': value,
      'currency': currency,
      'terms': terms,
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

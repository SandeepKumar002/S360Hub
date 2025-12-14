class ContracforceContractorStaffDocument {
  final String id;
  final String? orgId;
  final String? contractorStaffId;
  final String? documentType;
  final String? documentFileId;
  final bool? verified;
  final String? verifiedBy;
  final DateTime? verifiedDate;
  final DateTime? expiryDate;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;

  ContracforceContractorStaffDocument({
    required this.id,
    this.orgId,
    this.contractorStaffId,
    this.documentType,
    this.documentFileId,
    this.verified,
    this.verifiedBy,
    this.verifiedDate,
    this.expiryDate,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  factory ContracforceContractorStaffDocument.fromJson(Map<String, dynamic> json) {
    return ContracforceContractorStaffDocument(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      contractorStaffId: json['contractor_staff_id'] as String?,
      documentType: json['document_type'] as String?,
      documentFileId: json['document_file_id'] as String?,
      verified: json['verified'] as bool?,
      verifiedBy: json['verified_by'] as String?,
      verifiedDate: json['verified_date'] == null ? null : DateTime.parse(json['verified_date'] as String),
      expiryDate: json['expiry_date'] == null ? null : DateTime.parse(json['expiry_date'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'contractor_staff_id': contractorStaffId,
      'document_type': documentType,
      'document_file_id': documentFileId,
      'verified': verified,
      'verified_by': verifiedBy,
      'verified_date': verifiedDate?.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
    };
  }
}

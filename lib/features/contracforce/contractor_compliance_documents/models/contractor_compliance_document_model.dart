class ContracforceContractorComplianceDocument {
  final String id;
  final String? orgId;
  final String? contractorId;
  final String? documentType;
  final String? documentNumber;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String? documentFileId;
  final bool? verified;
  final String? verifiedBy;
  final DateTime? verifiedDate;
  final String? status;
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

  ContracforceContractorComplianceDocument({
    required this.id,
    this.orgId,
    this.contractorId,
    this.documentType,
    this.documentNumber,
    this.issueDate,
    this.expiryDate,
    this.documentFileId,
    this.verified,
    this.verifiedBy,
    this.verifiedDate,
    this.status,
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

  factory ContracforceContractorComplianceDocument.fromJson(Map<String, dynamic> json) {
    return ContracforceContractorComplianceDocument(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      contractorId: json['contractor_id'] as String?,
      documentType: json['document_type'] as String?,
      documentNumber: json['document_number'] as String?,
      issueDate: json['issue_date'] == null ? null : DateTime.parse(json['issue_date'] as String),
      expiryDate: json['expiry_date'] == null ? null : DateTime.parse(json['expiry_date'] as String),
      documentFileId: json['document_file_id'] as String?,
      verified: json['verified'] as bool?,
      verifiedBy: json['verified_by'] as String?,
      verifiedDate: json['verified_date'] == null ? null : DateTime.parse(json['verified_date'] as String),
      status: json['status'] as String?,
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
      'contractor_id': contractorId,
      'document_type': documentType,
      'document_number': documentNumber,
      'issue_date': issueDate?.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'document_file_id': documentFileId,
      'verified': verified,
      'verified_by': verifiedBy,
      'verified_date': verifiedDate?.toIso8601String(),
      'status': status,
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

class LedgieProposal {
  final String id;
  final String? orgId;
  final String? entityId;
  final String? proposalCode;
  final String? title;
  final String? sector;
  final String? proposalScope;
  final String? status;
  final DateTime? submittedDate;
  final DateTime? validUntil;
  final String? remarks;
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
  final String? leadsProspectId;

  LedgieProposal({
    required this.id,
    this.orgId,
    this.entityId,
    this.proposalCode,
    this.title,
    this.sector,
    this.proposalScope,
    this.status,
    this.submittedDate,
    this.validUntil,
    this.remarks,
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
    this.leadsProspectId,
  });

  factory LedgieProposal.fromJson(Map<String, dynamic> json) {
    return LedgieProposal(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      entityId: json['entity_id'] as String?,
      proposalCode: json['proposal_code'] as String?,
      title: json['title'] as String?,
      sector: json['sector'] as String?,
      proposalScope: json['proposal_scope'] as String?,
      status: json['status'] as String?,
      submittedDate: json['submitted_date'] == null ? null : DateTime.parse(json['submitted_date'] as String),
      validUntil: json['valid_until'] == null ? null : DateTime.parse(json['valid_until'] as String),
      remarks: json['remarks'] as String?,
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
      leadsProspectId: json['leads_prospect_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'entity_id': entityId,
      'proposal_code': proposalCode,
      'title': title,
      'sector': sector,
      'proposal_scope': proposalScope,
      'status': status,
      'submitted_date': submittedDate?.toIso8601String(),
      'valid_until': validUntil?.toIso8601String(),
      'remarks': remarks,
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
      'leads_prospect_id': leadsProspectId,
    };
  }
}

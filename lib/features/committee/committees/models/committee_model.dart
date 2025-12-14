class CommitteeCommittee {
  final String id;
  final String? orgId;
  final String? committeeName;
  final String? committeeType;
  final DateTime? formationDate;
  final String? validityPeriod;
  final DateTime? dissolutionDate;
  final String? committeeObjective;
  final String? committeeStatus;
  final String? charterFileId;
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

  CommitteeCommittee({
    required this.id,
    this.orgId,
    this.committeeName,
    this.committeeType,
    this.formationDate,
    this.validityPeriod,
    this.dissolutionDate,
    this.committeeObjective,
    this.committeeStatus,
    this.charterFileId,
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

  factory CommitteeCommittee.fromJson(Map<String, dynamic> json) {
    return CommitteeCommittee(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      committeeName: json['committee_name'] as String?,
      committeeType: json['committee_type'] as String?,
      formationDate: json['formation_date'] == null ? null : DateTime.parse(json['formation_date'] as String),
      validityPeriod: json['validity_period'] as String?,
      dissolutionDate: json['dissolution_date'] == null ? null : DateTime.parse(json['dissolution_date'] as String),
      committeeObjective: json['committee_objective'] as String?,
      committeeStatus: json['committee_status'] as String?,
      charterFileId: json['charter_file_id'] as String?,
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
      'committee_name': committeeName,
      'committee_type': committeeType,
      'formation_date': formationDate?.toIso8601String(),
      'validity_period': validityPeriod,
      'dissolution_date': dissolutionDate?.toIso8601String(),
      'committee_objective': committeeObjective,
      'committee_status': committeeStatus,
      'charter_file_id': charterFileId,
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

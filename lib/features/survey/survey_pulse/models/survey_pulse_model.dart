class SurveySurveyPulse {
  final String id;
  final String? orgId;
  final String? frequency;
  final DateTime? nextRun;
  final Map<String, dynamic>? targetGroups;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  SurveySurveyPulse({
    required this.id,
    this.orgId,
    this.frequency,
    this.nextRun,
    this.targetGroups,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.isDeleted,
  });

  factory SurveySurveyPulse.fromJson(Map<String, dynamic> json) {
    return SurveySurveyPulse(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      frequency: json['frequency'] as String?,
      nextRun: json['next_run'] == null ? null : DateTime.parse(json['next_run'] as String),
      targetGroups: json['target_groups'] as Map<String, dynamic>? ?? {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
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
      'frequency': frequency,
      'next_run': nextRun?.toIso8601String(),
      'target_groups': targetGroups,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
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

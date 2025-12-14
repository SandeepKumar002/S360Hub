class SurveyModuleTeamMember {
  final String id;
  final String? orgId;
  final String? teamId;
  final String? personId;
  final String? roleCode;
  final bool? isPrimary;
  final DateTime? joinedAt;
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

  SurveyModuleTeamMember({
    required this.id,
    this.orgId,
    this.teamId,
    this.personId,
    this.roleCode,
    this.isPrimary,
    this.joinedAt,
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

  factory SurveyModuleTeamMember.fromJson(Map<String, dynamic> json) {
    return SurveyModuleTeamMember(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      teamId: json['team_id'] as String?,
      personId: json['person_id'] as String?,
      roleCode: json['role_code'] as String?,
      isPrimary: json['is_primary'] as bool?,
      joinedAt: json['joined_at'] == null ? null : DateTime.parse(json['joined_at'] as String),
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
      'team_id': teamId,
      'person_id': personId,
      'role_code': roleCode,
      'is_primary': isPrimary,
      'joined_at': joinedAt?.toIso8601String(),
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

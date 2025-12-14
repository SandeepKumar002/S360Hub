class CommModuleRoleAssignment {
  final String id;
  final String? orgId;
  final String? roleId;
  final String? personId;
  final String? teamId;
  final Map<String, dynamic>? scope;
  final bool? active;
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

  CommModuleRoleAssignment({
    required this.id,
    this.orgId,
    this.roleId,
    this.personId,
    this.teamId,
    this.scope,
    this.active,
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

  factory CommModuleRoleAssignment.fromJson(Map<String, dynamic> json) {
    return CommModuleRoleAssignment(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      roleId: json['role_id'] as String?,
      personId: json['person_id'] as String?,
      teamId: json['team_id'] as String?,
      scope: json['scope'] as Map<String, dynamic>? ?? {},
      active: json['active'] as bool?,
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
      'role_id': roleId,
      'person_id': personId,
      'team_id': teamId,
      'scope': scope,
      'active': active,
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

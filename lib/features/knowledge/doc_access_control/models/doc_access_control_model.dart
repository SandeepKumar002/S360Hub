class KnowledgeDocAccessControl {
  final String id;
  final String? docId;
  final String? roleCode;
  final String? personId;
  final String? permission;
  final DateTime? createdAt;
  final String? orgId;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  KnowledgeDocAccessControl({
    required this.id,
    this.docId,
    this.roleCode,
    this.personId,
    this.permission,
    this.createdAt,
    this.orgId,
    this.updatedAt,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.isDeleted,
  });

  factory KnowledgeDocAccessControl.fromJson(Map<String, dynamic> json) {
    return KnowledgeDocAccessControl(
      id: json['id'] as String,
      docId: json['doc_id'] as String?,
      roleCode: json['role_code'] as String?,
      personId: json['person_id'] as String?,
      permission: json['permission'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      orgId: json['org_id'] as String?,
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
      'doc_id': docId,
      'role_code': roleCode,
      'person_id': personId,
      'permission': permission,
      'created_at': createdAt?.toIso8601String(),
      'org_id': orgId,
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

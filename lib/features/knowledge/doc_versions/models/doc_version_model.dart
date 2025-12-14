class KnowledgeDocVersion {
  final String id;
  final String? docId;
  final int? versionNo;
  final Map<String, dynamic>? content;
  final String? changedBy;
  final DateTime? changedAt;
  final String? notes;
  final String? orgId;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  KnowledgeDocVersion({
    required this.id,
    this.docId,
    this.versionNo,
    this.content,
    this.changedBy,
    this.changedAt,
    this.notes,
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

  factory KnowledgeDocVersion.fromJson(Map<String, dynamic> json) {
    return KnowledgeDocVersion(
      id: json['id'] as String,
      docId: json['doc_id'] as String?,
      versionNo: json['version_no'] as int?,
      content: json['content'] as Map<String, dynamic>? ?? {},
      changedBy: json['changed_by'] as String?,
      changedAt: json['changed_at'] == null ? null : DateTime.parse(json['changed_at'] as String),
      notes: json['notes'] as String?,
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
      'version_no': versionNo,
      'content': content,
      'changed_by': changedBy,
      'changed_at': changedAt?.toIso8601String(),
      'notes': notes,
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

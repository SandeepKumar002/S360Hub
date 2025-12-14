class LedgieEntityFile {
  final String id;
  final String? entityId;
  final String? fileId;
  final String? fileType;
  final String? fileStatus;
  final DateTime? uploadedAt;
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

  LedgieEntityFile({
    required this.id,
    this.entityId,
    this.fileId,
    this.fileType,
    this.fileStatus,
    this.uploadedAt,
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

  factory LedgieEntityFile.fromJson(Map<String, dynamic> json) {
    return LedgieEntityFile(
      id: json['id'] as String,
      entityId: json['entity_id'] as String?,
      fileId: json['file_id'] as String?,
      fileType: json['file_type'] as String?,
      fileStatus: json['file_status'] as String?,
      uploadedAt: json['uploaded_at'] == null ? null : DateTime.parse(json['uploaded_at'] as String),
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
      'entity_id': entityId,
      'file_id': fileId,
      'file_type': fileType,
      'file_status': fileStatus,
      'uploaded_at': uploadedAt?.toIso8601String(),
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

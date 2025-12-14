class TaxforgeFile {
  final String id;
  final String? orgId;
  final String? referenceTable;
  final String? referenceId;
  final String? fileType;
  final String? fileName;
  final String? storagePath;
  final String? contentType;
  final int? sizeBytes;
  final String? uploadedBy;
  final DateTime? uploadedAt;
  final bool? isDeleted;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final String? deleteReason;
  final String? restoreReason;
  final DateTime? restoredAt;
  final String? restoredBy;
  final DateTime? deletionScheduledAt;
  final DateTime? permanentDeletionDate;
  final int? deletionCount;
  final int? fileVersion;
  final String? previousVersionId;
  final bool? isArchived;
  final DateTime? archivedAt;
  final String? archivedBy;
  final String? archiveLocation;
  final String? checksum;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;

  TaxforgeFile({
    required this.id,
    this.orgId,
    this.referenceTable,
    this.referenceId,
    this.fileType,
    this.fileName,
    this.storagePath,
    this.contentType,
    this.sizeBytes,
    this.uploadedBy,
    this.uploadedAt,
    this.isDeleted,
    this.deletedAt,
    this.deletedBy,
    this.deleteType,
    this.deleteReason,
    this.restoreReason,
    this.restoredAt,
    this.restoredBy,
    this.deletionScheduledAt,
    this.permanentDeletionDate,
    this.deletionCount,
    this.fileVersion,
    this.previousVersionId,
    this.isArchived,
    this.archivedAt,
    this.archivedBy,
    this.archiveLocation,
    this.checksum,
    this.metadata,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.approvedAt,
    this.approvedBy,
  });

  factory TaxforgeFile.fromJson(Map<String, dynamic> json) {
    return TaxforgeFile(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      referenceTable: json['reference_table'] as String?,
      referenceId: json['reference_id'] as String?,
      fileType: json['file_type'] as String?,
      fileName: json['file_name'] as String?,
      storagePath: json['storage_path'] as String?,
      contentType: json['content_type'] as String?,
      sizeBytes: json['size_bytes'] as int?,
      uploadedBy: json['uploaded_by'] as String?,
      uploadedAt: json['uploaded_at'] == null ? null : DateTime.parse(json['uploaded_at'] as String),
      isDeleted: json['is_deleted'] as bool?,
      deletedAt: json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at'] as String),
      deletedBy: json['deleted_by'] as String?,
      deleteType: json['delete_type'] as String?,
      deleteReason: json['delete_reason'] as String?,
      restoreReason: json['restore_reason'] as String?,
      restoredAt: json['restored_at'] == null ? null : DateTime.parse(json['restored_at'] as String),
      restoredBy: json['restored_by'] as String?,
      deletionScheduledAt: json['deletion_scheduled_at'] == null ? null : DateTime.parse(json['deletion_scheduled_at'] as String),
      permanentDeletionDate: json['permanent_deletion_date'] == null ? null : DateTime.parse(json['permanent_deletion_date'] as String),
      deletionCount: json['deletion_count'] as int?,
      fileVersion: json['file_version'] as int?,
      previousVersionId: json['previous_version_id'] as String?,
      isArchived: json['is_archived'] as bool?,
      archivedAt: json['archived_at'] == null ? null : DateTime.parse(json['archived_at'] as String),
      archivedBy: json['archived_by'] as String?,
      archiveLocation: json['archive_location'] as String?,
      checksum: json['checksum'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
      updatedAt: json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String),
      updatedBy: json['updated_by'] as String?,
      approvedAt: json['approved_at'] == null ? null : DateTime.parse(json['approved_at'] as String),
      approvedBy: json['approved_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'reference_table': referenceTable,
      'reference_id': referenceId,
      'file_type': fileType,
      'file_name': fileName,
      'storage_path': storagePath,
      'content_type': contentType,
      'size_bytes': sizeBytes,
      'uploaded_by': uploadedBy,
      'uploaded_at': uploadedAt?.toIso8601String(),
      'is_deleted': isDeleted,
      'deleted_at': deletedAt?.toIso8601String(),
      'deleted_by': deletedBy,
      'delete_type': deleteType,
      'delete_reason': deleteReason,
      'restore_reason': restoreReason,
      'restored_at': restoredAt?.toIso8601String(),
      'restored_by': restoredBy,
      'deletion_scheduled_at': deletionScheduledAt?.toIso8601String(),
      'permanent_deletion_date': permanentDeletionDate?.toIso8601String(),
      'deletion_count': deletionCount,
      'file_version': fileVersion,
      'previous_version_id': previousVersionId,
      'is_archived': isArchived,
      'archived_at': archivedAt?.toIso8601String(),
      'archived_by': archivedBy,
      'archive_location': archiveLocation,
      'checksum': checksum,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'approved_at': approvedAt?.toIso8601String(),
      'approved_by': approvedBy,
    };
  }
}

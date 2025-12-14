class TrainingCertification {
  final String id;
  final String? employeeId;
  final String? courseId;
  final String? certificateNo;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String? fileId;
  final Map<String, dynamic>? metadata;
  final DateTime? createdAt;
  final String? createdBy;
  final String? orgId;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  TrainingCertification({
    required this.id,
    this.employeeId,
    this.courseId,
    this.certificateNo,
    this.issueDate,
    this.expiryDate,
    this.fileId,
    this.metadata,
    this.createdAt,
    this.createdBy,
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

  factory TrainingCertification.fromJson(Map<String, dynamic> json) {
    return TrainingCertification(
      id: json['id'] as String,
      employeeId: json['employee_id'] as String?,
      courseId: json['course_id'] as String?,
      certificateNo: json['certificate_no'] as String?,
      issueDate: json['issue_date'] == null ? null : DateTime.parse(json['issue_date'] as String),
      expiryDate: json['expiry_date'] == null ? null : DateTime.parse(json['expiry_date'] as String),
      fileId: json['file_id'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      createdBy: json['created_by'] as String?,
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
      'employee_id': employeeId,
      'course_id': courseId,
      'certificate_no': certificateNo,
      'issue_date': issueDate?.toIso8601String(),
      'expiry_date': expiryDate?.toIso8601String(),
      'file_id': fileId,
      'metadata': metadata,
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
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

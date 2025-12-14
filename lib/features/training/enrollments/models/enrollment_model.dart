class TrainingEnrollment {
  final String id;
  final String? sessionId;
  final String? employeeId;
  final String? status;
  final double? score;
  final DateTime? completedAt;
  final String? feedback;
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

  TrainingEnrollment({
    required this.id,
    this.sessionId,
    this.employeeId,
    this.status,
    this.score,
    this.completedAt,
    this.feedback,
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

  factory TrainingEnrollment.fromJson(Map<String, dynamic> json) {
    return TrainingEnrollment(
      id: json['id'] as String,
      sessionId: json['session_id'] as String?,
      employeeId: json['employee_id'] as String?,
      status: json['status'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      completedAt: json['completed_at'] == null ? null : DateTime.parse(json['completed_at'] as String),
      feedback: json['feedback'] as String?,
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
      'session_id': sessionId,
      'employee_id': employeeId,
      'status': status,
      'score': score,
      'completed_at': completedAt?.toIso8601String(),
      'feedback': feedback,
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

class TrainingSession {
  final String id;
  final String? courseId;
  final DateTime? sessionDateStart;
  final DateTime? sessionDateEnd;
  final String? instructorId;
  final String? location;
  final int? maxSeats;
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

  TrainingSession({
    required this.id,
    this.courseId,
    this.sessionDateStart,
    this.sessionDateEnd,
    this.instructorId,
    this.location,
    this.maxSeats,
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

  factory TrainingSession.fromJson(Map<String, dynamic> json) {
    return TrainingSession(
      id: json['id'] as String,
      courseId: json['course_id'] as String?,
      sessionDateStart: json['session_date_start'] == null ? null : DateTime.parse(json['session_date_start'] as String),
      sessionDateEnd: json['session_date_end'] == null ? null : DateTime.parse(json['session_date_end'] as String),
      instructorId: json['instructor_id'] as String?,
      location: json['location'] as String?,
      maxSeats: json['max_seats'] as int?,
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
      'course_id': courseId,
      'session_date_start': sessionDateStart?.toIso8601String(),
      'session_date_end': sessionDateEnd?.toIso8601String(),
      'instructor_id': instructorId,
      'location': location,
      'max_seats': maxSeats,
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

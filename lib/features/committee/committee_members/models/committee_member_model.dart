class CommitteeCommitteeMember {
  final String id;
  final String? committeeId;
  final String? personId;
  final String? memberRole;
  final DateTime? appointmentDate;
  final DateTime? termEndDate;
  final bool? isActive;
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

  CommitteeCommitteeMember({
    required this.id,
    this.committeeId,
    this.personId,
    this.memberRole,
    this.appointmentDate,
    this.termEndDate,
    this.isActive,
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

  factory CommitteeCommitteeMember.fromJson(Map<String, dynamic> json) {
    return CommitteeCommitteeMember(
      id: json['id'] as String,
      committeeId: json['committee_id'] as String?,
      personId: json['person_id'] as String?,
      memberRole: json['member_role'] as String?,
      appointmentDate: json['appointment_date'] == null ? null : DateTime.parse(json['appointment_date'] as String),
      termEndDate: json['term_end_date'] == null ? null : DateTime.parse(json['term_end_date'] as String),
      isActive: json['is_active'] as bool?,
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
      'committee_id': committeeId,
      'person_id': personId,
      'member_role': memberRole,
      'appointment_date': appointmentDate?.toIso8601String(),
      'term_end_date': termEndDate?.toIso8601String(),
      'is_active': isActive,
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

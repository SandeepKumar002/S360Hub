class CommitteeCommitteeMeeting {
  final String id;
  final String? committeeId;
  final String? meetingNumber;
  final DateTime? meetingDate;
  final String? meetingTime;
  final String? location;
  final String? agenda;
  final String? status;
  final Map<String, dynamic>? attendees;
  final String? minutesFileId;
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

  CommitteeCommitteeMeeting({
    required this.id,
    this.committeeId,
    this.meetingNumber,
    this.meetingDate,
    this.meetingTime,
    this.location,
    this.agenda,
    this.status,
    this.attendees,
    this.minutesFileId,
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

  factory CommitteeCommitteeMeeting.fromJson(Map<String, dynamic> json) {
    return CommitteeCommitteeMeeting(
      id: json['id'] as String,
      committeeId: json['committee_id'] as String?,
      meetingNumber: json['meeting_number'] as String?,
      meetingDate: json['meeting_date'] == null ? null : DateTime.parse(json['meeting_date'] as String),
      meetingTime: json['meeting_time'] as String?,
      location: json['location'] as String?,
      agenda: json['agenda'] as String?,
      status: json['status'] as String?,
      attendees: json['attendees'] as Map<String, dynamic>? ?? {},
      minutesFileId: json['minutes_file_id'] as String?,
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
      'meeting_number': meetingNumber,
      'meeting_date': meetingDate?.toIso8601String(),
      'meeting_time': meetingTime,
      'location': location,
      'agenda': agenda,
      'status': status,
      'attendees': attendees,
      'minutes_file_id': minutesFileId,
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

class ShieldPoshComplaint {
  final String id;
  final String? orgId;
  final String? complaintId;
  final String? complaintType;
  final String? description;
  final DateTime? complaintDate;
  final String? complainantId;
  final String? complainantName;
  final String? respondentId;
  final String? respondentName;
  final String? locationGeo;
  final String? supportingFileId;
  final bool? confidentialityRequested;
  final String? status;
  final String? assignedTo;
  final String? assignedCommitteeId;
  final DateTime? investigationStart;
  final DateTime? investigationEnd;
  final String? resolutionDescription;
  final DateTime? resolutionDate;
  final String? actionTaken;
  final bool? followupRequired;
  final DateTime? followupDate;
  final String? escalationLevel;
  final String? actionTakenBy;
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

  ShieldPoshComplaint({
    required this.id,
    this.orgId,
    this.complaintId,
    this.complaintType,
    this.description,
    this.complaintDate,
    this.complainantId,
    this.complainantName,
    this.respondentId,
    this.respondentName,
    this.locationGeo,
    this.supportingFileId,
    this.confidentialityRequested,
    this.status,
    this.assignedTo,
    this.assignedCommitteeId,
    this.investigationStart,
    this.investigationEnd,
    this.resolutionDescription,
    this.resolutionDate,
    this.actionTaken,
    this.followupRequired,
    this.followupDate,
    this.escalationLevel,
    this.actionTakenBy,
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

  factory ShieldPoshComplaint.fromJson(Map<String, dynamic> json) {
    return ShieldPoshComplaint(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      complaintId: json['complaint_id'] as String?,
      complaintType: json['complaint_type'] as String?,
      description: json['description'] as String?,
      complaintDate: json['complaint_date'] == null ? null : DateTime.parse(json['complaint_date'] as String),
      complainantId: json['complainant_id'] as String?,
      complainantName: json['complainant_name'] as String?,
      respondentId: json['respondent_id'] as String?,
      respondentName: json['respondent_name'] as String?,
      locationGeo: json['location_geo'] as String?,
      supportingFileId: json['supporting_file_id'] as String?,
      confidentialityRequested: json['confidentiality_requested'] as bool?,
      status: json['status'] as String?,
      assignedTo: json['assigned_to'] as String?,
      assignedCommitteeId: json['assigned_committee_id'] as String?,
      investigationStart: json['investigation_start'] == null ? null : DateTime.parse(json['investigation_start'] as String),
      investigationEnd: json['investigation_end'] == null ? null : DateTime.parse(json['investigation_end'] as String),
      resolutionDescription: json['resolution_description'] as String?,
      resolutionDate: json['resolution_date'] == null ? null : DateTime.parse(json['resolution_date'] as String),
      actionTaken: json['action_taken'] as String?,
      followupRequired: json['followup_required'] as bool?,
      followupDate: json['followup_date'] == null ? null : DateTime.parse(json['followup_date'] as String),
      escalationLevel: json['escalation_level'] as String?,
      actionTakenBy: json['action_taken_by'] as String?,
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
      'org_id': orgId,
      'complaint_id': complaintId,
      'complaint_type': complaintType,
      'description': description,
      'complaint_date': complaintDate?.toIso8601String(),
      'complainant_id': complainantId,
      'complainant_name': complainantName,
      'respondent_id': respondentId,
      'respondent_name': respondentName,
      'location_geo': locationGeo,
      'supporting_file_id': supportingFileId,
      'confidentiality_requested': confidentialityRequested,
      'status': status,
      'assigned_to': assignedTo,
      'assigned_committee_id': assignedCommitteeId,
      'investigation_start': investigationStart?.toIso8601String(),
      'investigation_end': investigationEnd?.toIso8601String(),
      'resolution_description': resolutionDescription,
      'resolution_date': resolutionDate?.toIso8601String(),
      'action_taken': actionTaken,
      'followup_required': followupRequired,
      'followup_date': followupDate?.toIso8601String(),
      'escalation_level': escalationLevel,
      'action_taken_by': actionTakenBy,
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

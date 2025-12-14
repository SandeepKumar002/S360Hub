class ShieldGrievanceComplaint {
  final String id;
  final String? orgId;
  final String? complaintId;
  final String? complaintType;
  final String? description;
  final DateTime? complaintDate;
  final String? complainantId;
  final String? respondentId;
  final String? status;
  final String? assignedTo;
  final String? resolutionDescription;
  final DateTime? resolutionDate;
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

  ShieldGrievanceComplaint({
    required this.id,
    this.orgId,
    this.complaintId,
    this.complaintType,
    this.description,
    this.complaintDate,
    this.complainantId,
    this.respondentId,
    this.status,
    this.assignedTo,
    this.resolutionDescription,
    this.resolutionDate,
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

  factory ShieldGrievanceComplaint.fromJson(Map<String, dynamic> json) {
    return ShieldGrievanceComplaint(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      complaintId: json['complaint_id'] as String?,
      complaintType: json['complaint_type'] as String?,
      description: json['description'] as String?,
      complaintDate: json['complaint_date'] == null ? null : DateTime.parse(json['complaint_date'] as String),
      complainantId: json['complainant_id'] as String?,
      respondentId: json['respondent_id'] as String?,
      status: json['status'] as String?,
      assignedTo: json['assigned_to'] as String?,
      resolutionDescription: json['resolution_description'] as String?,
      resolutionDate: json['resolution_date'] == null ? null : DateTime.parse(json['resolution_date'] as String),
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
      'respondent_id': respondentId,
      'status': status,
      'assigned_to': assignedTo,
      'resolution_description': resolutionDescription,
      'resolution_date': resolutionDate?.toIso8601String(),
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

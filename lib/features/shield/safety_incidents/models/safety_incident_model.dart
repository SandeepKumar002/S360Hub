class ShieldSafetyIncident {
  final String id;
  final String? orgId;
  final String? incidentId;
  final DateTime? incidentDate;
  final String? location;
  final String? locationGps;
  final String? severity;
  final String? description;
  final bool? injuriesReported;
  final Map<String, dynamic>? injuredPersons;
  final String? immediateActionTaken;
  final bool? investigationRequired;
  final String? investigationFileId;
  final String? preventiveMeasures;
  final String? status;
  final String? reportedBy;
  final String? assignedTo;
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

  ShieldSafetyIncident({
    required this.id,
    this.orgId,
    this.incidentId,
    this.incidentDate,
    this.location,
    this.locationGps,
    this.severity,
    this.description,
    this.injuriesReported,
    this.injuredPersons,
    this.immediateActionTaken,
    this.investigationRequired,
    this.investigationFileId,
    this.preventiveMeasures,
    this.status,
    this.reportedBy,
    this.assignedTo,
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

  factory ShieldSafetyIncident.fromJson(Map<String, dynamic> json) {
    return ShieldSafetyIncident(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      incidentId: json['incident_id'] as String?,
      incidentDate: json['incident_date'] == null ? null : DateTime.parse(json['incident_date'] as String),
      location: json['location'] as String?,
      locationGps: json['location_gps'] as String?,
      severity: json['severity'] as String?,
      description: json['description'] as String?,
      injuriesReported: json['injuries_reported'] as bool?,
      injuredPersons: json['injured_persons'] as Map<String, dynamic>? ?? {},
      immediateActionTaken: json['immediate_action_taken'] as String?,
      investigationRequired: json['investigation_required'] as bool?,
      investigationFileId: json['investigation_file_id'] as String?,
      preventiveMeasures: json['preventive_measures'] as String?,
      status: json['status'] as String?,
      reportedBy: json['reported_by'] as String?,
      assignedTo: json['assigned_to'] as String?,
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
      'incident_id': incidentId,
      'incident_date': incidentDate?.toIso8601String(),
      'location': location,
      'location_gps': locationGps,
      'severity': severity,
      'description': description,
      'injuries_reported': injuriesReported,
      'injured_persons': injuredPersons,
      'immediate_action_taken': immediateActionTaken,
      'investigation_required': investigationRequired,
      'investigation_file_id': investigationFileId,
      'preventive_measures': preventiveMeasures,
      'status': status,
      'reported_by': reportedBy,
      'assigned_to': assignedTo,
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

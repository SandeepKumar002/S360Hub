class LedgieActiveProspect {
  final String id;
  final String? entityCode;
  final String? companyName;
  final String? entityStatus;
  final String? leadTemperature;
  final String? leadPriority;
  final String? leadSource;
  final double? estimatedValue;
  final DateTime? nextFollowUpDate;
  final DateTime? lastContactDate;
  final int? interactionCount;
  final String? assignedTo;
  final String? assignedToName;
  final DateTime? createdAt;
  final String? orgId;

  LedgieActiveProspect({
    required this.id,
    this.entityCode,
    this.companyName,
    this.entityStatus,
    this.leadTemperature,
    this.leadPriority,
    this.leadSource,
    this.estimatedValue,
    this.nextFollowUpDate,
    this.lastContactDate,
    this.interactionCount,
    this.assignedTo,
    this.assignedToName,
    this.createdAt,
    this.orgId,
  });

  factory LedgieActiveProspect.fromJson(Map<String, dynamic> json) {
    return LedgieActiveProspect(
      id: json['id'] as String,
      entityCode: json['entity_code'] as String?,
      companyName: json['company_name'] as String?,
      entityStatus: json['entity_status'] as String?,
      leadTemperature: json['lead_temperature'] as String?,
      leadPriority: json['lead_priority'] as String?,
      leadSource: json['lead_source'] as String?,
      estimatedValue: (json['estimated_value'] as num?)?.toDouble(),
      nextFollowUpDate: json['next_follow_up_date'] == null ? null : DateTime.parse(json['next_follow_up_date'] as String),
      lastContactDate: json['last_contact_date'] == null ? null : DateTime.parse(json['last_contact_date'] as String),
      interactionCount: json['interaction_count'] as int?,
      assignedTo: json['assigned_to'] as String?,
      assignedToName: json['assigned_to_name'] as String?,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      orgId: json['org_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entity_code': entityCode,
      'company_name': companyName,
      'entity_status': entityStatus,
      'lead_temperature': leadTemperature,
      'lead_priority': leadPriority,
      'lead_source': leadSource,
      'estimated_value': estimatedValue,
      'next_follow_up_date': nextFollowUpDate?.toIso8601String(),
      'last_contact_date': lastContactDate?.toIso8601String(),
      'interaction_count': interactionCount,
      'assigned_to': assignedTo,
      'assigned_to_name': assignedToName,
      'created_at': createdAt?.toIso8601String(),
      'org_id': orgId,
    };
  }
}

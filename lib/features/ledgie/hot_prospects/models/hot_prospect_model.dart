class LedgieHotProspect {
  final String id;
  final String? companyName;
  final String? entityStatus;
  final String? leadPriority;
  final double? estimatedValue;
  final DateTime? nextFollowUpDate;
  final DateTime? lastContactDate;
  final String? assignedTo;
  final String? assignedToName;
  final String? urgency;
  final String? orgId;

  LedgieHotProspect({
    required this.id,
    this.companyName,
    this.entityStatus,
    this.leadPriority,
    this.estimatedValue,
    this.nextFollowUpDate,
    this.lastContactDate,
    this.assignedTo,
    this.assignedToName,
    this.urgency,
    this.orgId,
  });

  factory LedgieHotProspect.fromJson(Map<String, dynamic> json) {
    return LedgieHotProspect(
      id: json['id'] as String,
      companyName: json['company_name'] as String?,
      entityStatus: json['entity_status'] as String?,
      leadPriority: json['lead_priority'] as String?,
      estimatedValue: (json['estimated_value'] as num?)?.toDouble(),
      nextFollowUpDate: json['next_follow_up_date'] == null ? null : DateTime.parse(json['next_follow_up_date'] as String),
      lastContactDate: json['last_contact_date'] == null ? null : DateTime.parse(json['last_contact_date'] as String),
      assignedTo: json['assigned_to'] as String?,
      assignedToName: json['assigned_to_name'] as String?,
      urgency: json['urgency'] as String?,
      orgId: json['org_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'entity_status': entityStatus,
      'lead_priority': leadPriority,
      'estimated_value': estimatedValue,
      'next_follow_up_date': nextFollowUpDate?.toIso8601String(),
      'last_contact_date': lastContactDate?.toIso8601String(),
      'assigned_to': assignedTo,
      'assigned_to_name': assignedToName,
      'urgency': urgency,
      'org_id': orgId,
    };
  }
}

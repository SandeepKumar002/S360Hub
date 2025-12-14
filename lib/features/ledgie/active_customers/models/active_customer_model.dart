class LedgieActiveCustomer {
  final String id;
  final String? entityCode;
  final String? name;
  final String? type;
  final String? entityStatus;
  final String? country;
  final String? state;
  final String? pan;
  final String? website;
  final String? assignedTo;
  final String? assignedToName;
  final DateTime? convertedDate;
  final DateTime? createdAt;
  final String? orgId;

  LedgieActiveCustomer({
    required this.id,
    this.entityCode,
    this.name,
    this.type,
    this.entityStatus,
    this.country,
    this.state,
    this.pan,
    this.website,
    this.assignedTo,
    this.assignedToName,
    this.convertedDate,
    this.createdAt,
    this.orgId,
  });

  factory LedgieActiveCustomer.fromJson(Map<String, dynamic> json) {
    return LedgieActiveCustomer(
      id: json['id'] as String,
      entityCode: json['entity_code'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      entityStatus: json['entity_status'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      pan: json['pan'] as String?,
      website: json['website'] as String?,
      assignedTo: json['assigned_to'] as String?,
      assignedToName: json['assigned_to_name'] as String?,
      convertedDate: json['converted_date'] == null ? null : DateTime.parse(json['converted_date'] as String),
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
      orgId: json['org_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entity_code': entityCode,
      'name': name,
      'type': type,
      'entity_status': entityStatus,
      'country': country,
      'state': state,
      'pan': pan,
      'website': website,
      'assigned_to': assignedTo,
      'assigned_to_name': assignedToName,
      'converted_date': convertedDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'org_id': orgId,
    };
  }
}

class LedgieEntitie {
  final String id;
  final String? orgId;
  final String? entityCode;
  final String? name;
  final String? type;
  final String? primaryContactId;
  final String? country;
  final String? state;
  final String? district;
  final String? pincode;
  final String? gstDefaultId;
  final String? pan;
  final String? website;
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
  final String? entityStatus;
  final String? leadSource;
  final String? leadTemperature;
  final String? leadPriority;
  final String? assignedTo;
  final DateTime? firstContactDate;
  final DateTime? lastContactDate;
  final DateTime? nextFollowUpDate;
  final double? estimatedValue;
  final DateTime? expectedCloseDate;
  final DateTime? convertedDate;
  final int? interactionCount;
  final String? notes;

  LedgieEntitie({
    required this.id,
    this.orgId,
    this.entityCode,
    this.name,
    this.type,
    this.primaryContactId,
    this.country,
    this.state,
    this.district,
    this.pincode,
    this.gstDefaultId,
    this.pan,
    this.website,
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
    this.entityStatus,
    this.leadSource,
    this.leadTemperature,
    this.leadPriority,
    this.assignedTo,
    this.firstContactDate,
    this.lastContactDate,
    this.nextFollowUpDate,
    this.estimatedValue,
    this.expectedCloseDate,
    this.convertedDate,
    this.interactionCount,
    this.notes,
  });

  factory LedgieEntitie.fromJson(Map<String, dynamic> json) {
    return LedgieEntitie(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      entityCode: json['entity_code'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      primaryContactId: json['primary_contact_id'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      pincode: json['pincode'] as String?,
      gstDefaultId: json['gst_default_id'] as String?,
      pan: json['pan'] as String?,
      website: json['website'] as String?,
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
      entityStatus: json['entity_status'] as String?,
      leadSource: json['lead_source'] as String?,
      leadTemperature: json['lead_temperature'] as String?,
      leadPriority: json['lead_priority'] as String?,
      assignedTo: json['assigned_to'] as String?,
      firstContactDate: json['first_contact_date'] == null ? null : DateTime.parse(json['first_contact_date'] as String),
      lastContactDate: json['last_contact_date'] == null ? null : DateTime.parse(json['last_contact_date'] as String),
      nextFollowUpDate: json['next_follow_up_date'] == null ? null : DateTime.parse(json['next_follow_up_date'] as String),
      estimatedValue: (json['estimated_value'] as num?)?.toDouble(),
      expectedCloseDate: json['expected_close_date'] == null ? null : DateTime.parse(json['expected_close_date'] as String),
      convertedDate: json['converted_date'] == null ? null : DateTime.parse(json['converted_date'] as String),
      interactionCount: json['interaction_count'] as int?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'org_id': orgId,
      'entity_code': entityCode,
      'name': name,
      'type': type,
      'primary_contact_id': primaryContactId,
      'country': country,
      'state': state,
      'district': district,
      'pincode': pincode,
      'gst_default_id': gstDefaultId,
      'pan': pan,
      'website': website,
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
      'entity_status': entityStatus,
      'lead_source': leadSource,
      'lead_temperature': leadTemperature,
      'lead_priority': leadPriority,
      'assigned_to': assignedTo,
      'first_contact_date': firstContactDate?.toIso8601String(),
      'last_contact_date': lastContactDate?.toIso8601String(),
      'next_follow_up_date': nextFollowUpDate?.toIso8601String(),
      'estimated_value': estimatedValue,
      'expected_close_date': expectedCloseDate?.toIso8601String(),
      'converted_date': convertedDate?.toIso8601String(),
      'interaction_count': interactionCount,
      'notes': notes,
    };
  }
}

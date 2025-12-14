class CommNotification {
  final String id;
  final String? personId;
  final String? referenceTable;
  final String? referenceId;
  final String? type;
  final Map<String, dynamic>? payload;
  final bool? delivered;
  final DateTime? readAt;
  final DateTime? createdAt;
  final String? orgId;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime? deletedAt;
  final String? deletedBy;
  final String? deleteType;
  final bool? isDeleted;

  CommNotification({
    required this.id,
    this.personId,
    this.referenceTable,
    this.referenceId,
    this.type,
    this.payload,
    this.delivered,
    this.readAt,
    this.createdAt,
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

  factory CommNotification.fromJson(Map<String, dynamic> json) {
    return CommNotification(
      id: json['id'] as String,
      personId: json['person_id'] as String?,
      referenceTable: json['reference_table'] as String?,
      referenceId: json['reference_id'] as String?,
      type: json['type'] as String?,
      payload: json['payload'] as Map<String, dynamic>? ?? {},
      delivered: json['delivered'] as bool?,
      readAt: json['read_at'] == null ? null : DateTime.parse(json['read_at'] as String),
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
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
      'person_id': personId,
      'reference_table': referenceTable,
      'reference_id': referenceId,
      'type': type,
      'payload': payload,
      'delivered': delivered,
      'read_at': readAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
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

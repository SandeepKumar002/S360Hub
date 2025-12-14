class ShieldPpeIssued {
  final String id;
  final String? orgId;
  final String? employeeId;
  final String? ppeType;
  final String? ppeDescription;
  final int? quantity;
  final DateTime? issueDate;
  final DateTime? expectedReturnDate;
  final String? issuedBy;
  final String? acknowledgementFileId;
  final String? status;
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

  ShieldPpeIssued({
    required this.id,
    this.orgId,
    this.employeeId,
    this.ppeType,
    this.ppeDescription,
    this.quantity,
    this.issueDate,
    this.expectedReturnDate,
    this.issuedBy,
    this.acknowledgementFileId,
    this.status,
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

  factory ShieldPpeIssued.fromJson(Map<String, dynamic> json) {
    return ShieldPpeIssued(
      id: json['id'] as String,
      orgId: json['org_id'] as String?,
      employeeId: json['employee_id'] as String?,
      ppeType: json['ppe_type'] as String?,
      ppeDescription: json['ppe_description'] as String?,
      quantity: json['quantity'] as int?,
      issueDate: json['issue_date'] == null ? null : DateTime.parse(json['issue_date'] as String),
      expectedReturnDate: json['expected_return_date'] == null ? null : DateTime.parse(json['expected_return_date'] as String),
      issuedBy: json['issued_by'] as String?,
      acknowledgementFileId: json['acknowledgement_file_id'] as String?,
      status: json['status'] as String?,
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
      'employee_id': employeeId,
      'ppe_type': ppeType,
      'ppe_description': ppeDescription,
      'quantity': quantity,
      'issue_date': issueDate?.toIso8601String(),
      'expected_return_date': expectedReturnDate?.toIso8601String(),
      'issued_by': issuedBy,
      'acknowledgement_file_id': acknowledgementFileId,
      'status': status,
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
